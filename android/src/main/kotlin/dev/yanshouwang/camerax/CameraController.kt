package dev.yanshouwang.camerax

import android.app.Activity
import android.graphics.ImageFormat
import android.media.Image
import android.util.Log
import android.view.Surface
import androidx.camera.core.*
import androidx.camera.core.ImageProxy
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.protobuf.ByteString
import com.theeasiestway.yuv.Constants
import com.theeasiestway.yuv.YuvUtils
import dev.yanshouwang.camerax.messages.*
import dev.yanshouwang.camerax.messages.Messages.*
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.TextureRegistry
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

class CameraController(
    private val activity: Activity,
    val textureEntry: TextureRegistry.SurfaceTextureEntry,
    private val selector: Messages.CameraSelector,) {

    private var camera: Camera? = null
    private var preview: Preview? = null
    private var imageAnalysis: ImageAnalysis? = null
    private val mainExecutor = ContextCompat.getMainExecutor(activity)
    private val methodExecutor = Executors.newSingleThreadExecutor()
    private var imageProxies: MutableMap<String, ImageProxy> = mutableMapOf()

    var eventSink: EventChannel.EventSink? = null

    fun bind(result: MethodChannel.Result) {
        initCamera(result)
    }

    fun unBind(arguments: CameraControllerUnbindCommandArguments, result: MethodChannel.Result) {
        val listenable = ProcessCameraProvider.getInstance(activity)
        listenable.addListener({
            try {
                val provider = listenable.get()
                provider.unbind(preview, imageAnalysis)
                textureEntry.release()
                result.success()
            } catch (e: Exception) {
                result.error(e)
            }
        }, mainExecutor)
    }

    fun handleTorch(arguments: CameraControllerTorchCommandArguments, result: MethodChannel.Result) {
        val state = arguments.state
        val listenable = camera?.cameraControl?.enableTorch(state)
        listenable?.addListener({
            try {
                listenable.get()
                result.success()
            } catch (e: Exception) {
                result.error(e)
            }
        }, mainExecutor)
    }

    fun handleZoom(arguments: CameraControllerZoomCommandArguments, result: MethodChannel.Result) {
        val ratio = arguments.value.toFloat()
        val listenable = camera?.cameraControl?.setZoomRatio(ratio)
        listenable?.addListener({
            try {
                listenable.get()
                result.success()
            } catch (e: Exception) {
                result.error(e)
            }
        }, mainExecutor)
    }

    fun handleFocusAutomatically(arguments: CameraControllerFocusAutomaticallyCommandArguments, result: MethodChannel.Result) {
        val listenable = camera?.cameraControl?.cancelFocusAndMetering()
        listenable?.addListener({
            try {
                listenable.get()
                result.success()
            } catch (e: Exception) {
                result.error(e)
            }
        }, mainExecutor)
    }

    fun handleFocusManually(arguments: CameraControllerFocusManuallyCommandArguments, result: MethodChannel.Result) {
        val width = arguments.width.toFloat()
        val height = arguments.height.toFloat()
        val x = arguments.x.toFloat()
        val y = arguments.y.toFloat()
        val cameraInfo = camera?.cameraInfo
        // 转到相机方向需要的角度（逆时针）
        var rotationDegrees =
            ((cameraInfo?.sensorRotationDegrees ?: 0) - activity.rotationDegrees) % 360
        if (rotationDegrees < 0) {
            rotationDegrees += 360
        }
        val point = when (rotationDegrees) {
            0 -> {
                SurfaceOrientedMeteringPointFactory(width, height).createPoint(x, y)
            }
            90 -> {
                SurfaceOrientedMeteringPointFactory(height, width).createPoint(
                    y,
                    width - x
                )
            }
            180 -> {
                SurfaceOrientedMeteringPointFactory(
                    width,
                    height
                ).createPoint(width - x, height - y)
            }
            270 -> {
                SurfaceOrientedMeteringPointFactory(
                    height,
                    width
                ).createPoint(height - y, x)
            }
            else -> {
                throw NotImplementedError()
            }
        }
        val action = FocusMeteringAction.Builder(point, FocusMeteringAction.FLAG_AF)
            .disableAutoCancel()
            .build()
        val listenable = camera?.cameraControl?.startFocusAndMetering(action)
        // TODO: 目前 CameraX 在某些手机上不触发回调，等待官方解决
        methodExecutor.execute {
            try {
                val fmr = listenable?.get(5000, TimeUnit.MILLISECONDS)
                if (fmr != null) {
                    if (!fmr.isFocusSuccessful) {
                        throw IllegalStateException("focusManually failed with $arguments.")
                    }
                }
                invokeOnMainThread { result.success() }
            } catch (e: TimeoutException) {
                Log.d(TAG, e.localizedMessage ?: "focusManually failed with $e.")
                invokeOnMainThread { result.success() }
            } catch (e: Exception) {
                invokeOnMainThread { result.error(e) }
            }
         }
    }

    fun handleImageProxy(arguments: ImageProxyCloseCommandArguments, result: MethodChannel.Result) {
        val id = arguments.id
        // 相机关闭后会释放 ImageProxy 实例
        val imageProxy = imageProxies.remove(id)!!
        imageProxy.close()
        result.success()
    }

    private fun initCamera(result: MethodChannel.Result) {
        if (camera == null) {
            val listenable = ProcessCameraProvider.getInstance(activity)
            listenable.addListener({
                try {
                    val provider = listenable.get()
                    val lifecycleOwner = activity as LifecycleOwner
                    preview = Preview.Builder()
                        .setTargetRotation(Surface.ROTATION_0)
                        .build()
                    imageAnalysis = ImageAnalysis.Builder()
                        .setTargetRotation(Surface.ROTATION_0)
                        .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                        .build()
                    camera = provider.bindToLifecycle(
                        lifecycleOwner,
                        selector.cameraxSelector,
                        preview,
                        imageAnalysis
                    )
                    configPreView(result)
                    configAnalysis()
                } catch (e : java.lang.Exception) {
                    e.printStackTrace()
                }
            }, mainExecutor)
        }
    }

    private fun configPreView(result: MethodChannel.Result) {
        preview?.setSurfaceProvider { request ->
            val texture = textureEntry.surfaceTexture()
            val resolution = request.resolution
            texture.setDefaultBufferSize(
                resolution.width,
                resolution.height
            )
            val surface = Surface(texture)
            request.provideSurface(surface, mainExecutor) { }
            val reply = reply {
                this.cameraControllerBindArguments =
                    cameraControllerBindReplyArguments {
                        this.cameraValue = cameraValue {
                            this.textureId = textureEntry.id().toInt()
                            val cameraInfo = camera?.cameraInfo
                            if (cameraInfo != null) {
                                if (cameraInfo.sensorRotationDegrees % 180 == 0) {
                                    this.textureWidth = resolution.width
                                    this.textureHeight = resolution.height
                                } else {
                                    this.textureWidth = resolution.height
                                    this.textureHeight = resolution.width
                                }
                                this.torchAvailable =
                                    cameraInfo.hasFlashUnit()
                                val zoomState = cameraInfo.zoomState.value!!
                                this.zoomMinimum =
                                    zoomState.minZoomRatio.toDouble()
                                this.zoomMaximum =
                                    zoomState.maxZoomRatio.toDouble()
                            }
                        }
                    }
            }.toByteArray()
            result.success(reply)
        }
    }

    private fun configAnalysis() {
        val imageAnalysisExecutor = Executors.newSingleThreadExecutor()
        imageAnalysis?.setAnalyzer(imageAnalysisExecutor) { imageProxy ->
            if (imageProxy.format != ImageFormat.YUV_420_888) {
                val errorMessage =
                    "The image proxy's format is unsupported: ${imageProxy.format}"
                eventSink?.error(TAG, errorMessage)
            }

            val imageProxyId = imageProxy.hashCode().toString()
            imageProxies[imageProxyId] = imageProxy
            val event = event {
                this.category =
                    EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXIED
                this.cameraControllerImageProxiedArguments =
                    cameraControllerImageProxiedEventArguments {
                        this.imageProxy = imageProxy {
                            this.selector = selector
                            this.id = imageProxyId
                            val imageBytes: ByteArray
                            val imageWidth: Int
                            val imageHeight: Int

                            // 计算需要旋转的角度
                            var rotationDegrees =
                                (imageProxy.imageInfo.rotationDegrees - activity.rotationDegrees) % 360
                            if (rotationDegrees < 0) {
                                rotationDegrees += 360
                            }
                            when (rotationDegrees) {
                                0 -> {
                                    imageBytes = rotateImage(imageProxy, Constants.ROTATE_0)
                                    imageWidth = imageProxy.width
                                    imageHeight = imageProxy.height
                                }
                                90 -> {
                                    imageBytes = rotateImage(imageProxy, Constants.ROTATE_90)
                                    imageWidth = imageProxy.height
                                    imageHeight = imageProxy.width
                                }
                                180 -> {
                                    imageBytes = rotateImage(imageProxy, Constants.ROTATE_180)
                                    imageWidth = imageProxy.width
                                    imageHeight = imageProxy.height
                                }
                                270 -> {
                                    imageBytes = rotateImage(imageProxy, Constants.ROTATE_270)
                                    imageWidth = imageProxy.height
                                    imageHeight = imageProxy.width
                                }
                                else -> {
                                    throw NotImplementedError()
                                }
                            }
                            this.data = ByteString.copyFrom(imageBytes)
                            this.width = imageWidth
                            this.height = imageHeight
                        }
                    }
            }.toByteArray()
            invokeOnMainThread { eventSink?.success(event) }
        }
    }

    private fun invokeOnMainThread(action: Runnable) {
        activity.runOnUiThread(action)
    }


    private fun rotateImage(imageProxy: ImageProxy, rotateDegree: Int) : ByteArray {
        var byteArray = byteArrayOf()
        if (imageProxy.image != null && imageProxy.image is Image) {
            val rImage = YuvUtils().rotate(imageProxy.image!!, rotateDegree)
            byteArray = rImage.asArray()

//            val argbFrame = YuvUtils().yuv420ToArgb(rImage)
//            val bm = Bitmap.createBitmap(rImage.width, rImage.height, Bitmap.Config.ARGB_8888)
//            bm.copyPixelsFromBuffer(ByteBuffer.wrap(argbFrame.asArray())) // for displaying argb
        }
        return byteArray
    }
}