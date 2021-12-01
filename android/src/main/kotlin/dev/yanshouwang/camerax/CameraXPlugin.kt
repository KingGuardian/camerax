package dev.yanshouwang.camerax

import android.Manifest
import android.content.pm.PackageManager
import android.graphics.ImageFormat
import android.util.Size
import android.view.Surface
import androidx.annotation.NonNull
import androidx.camera.core.*
import androidx.camera.core.CameraSelector
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.util.Consumer
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import com.google.protobuf.ByteString
import io.flutter.BuildConfig
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.*
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import java.util.*
import java.util.concurrent.Executors
import kotlin.concurrent.timerTask

typealias RequestPermissionsGrantedHandler = (granted: Boolean) -> Unit

/** CameraXPlugin */
class CameraXPlugin : FlutterPlugin, ActivityAware, MethodCallHandler, StreamHandler,
    RequestPermissionsResultListener {
    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        private const val REQUEST_CODE = 3543
    }

    private lateinit var flutterPluginBinding: FlutterPluginBinding
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    private var activityPluginBinding: ActivityPluginBinding? = null
    private var eventSink: EventSink? = null

    private var quarterTurns = 0
    private val quarterTurnsTimer by lazy { Timer() }

    private val requestPermissionsGrantedHandlers by lazy { mutableListOf<RequestPermissionsGrantedHandler>() }

    private val nativeCameras by lazy { mutableMapOf<String, NativeCamera>() }
    private val nativeImageProxies by lazy { mutableMapOf<String, NativeImageProxy>() }

    override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
        flutterPluginBinding = binding
        val messenger = binding.binaryMessenger
        methodChannel = MethodChannel(messenger, "$NAMESPACE/method")
        eventChannel = EventChannel(messenger, "$NAMESPACE/event")
        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityPluginBinding = binding
        activityPluginBinding!!.addRequestPermissionsResultListener(this)
        val task = timerTask {
            val activity = activityPluginBinding?.activity ?: return@timerTask
            val quarterTurns = activity.quarterTurns
            if (this@CameraXPlugin.quarterTurns != quarterTurns) {
                this@CameraXPlugin.quarterTurns = quarterTurns
                // 设备方向变化
                val event = event {
                    this.category = Messages.EventCategory.EVENT_CATEGORY_QUARTER_TURNS
                    this.quarterTurns = quarterTurns
                }.toByteArray()
                activity.runOnUiThread { eventSink?.success(event) }
            }
        }
        quarterTurnsTimer.schedule(task, 0L, 100L)
    }

    override fun onDetachedFromActivity() {
        val binding = this.activityPluginBinding!!
        for (nativeImageProxy in nativeImageProxies.values) {
            val imageProxy = nativeImageProxy.value
            imageProxy.close()
        }
        nativeImageProxies.clear()
        for (nativeCamera in nativeCameras.values) {
            val camera = nativeCamera.value
            val owner = binding.activity as LifecycleOwner
            camera.cameraInfo.torchState.removeObservers(owner)
        }
        nativeCameras.clear()
        quarterTurnsTimer.cancel()
        binding.removeRequestPermissionsResultListener(this)
        this.activityPluginBinding = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val methodArguments = call.methodArguments
        when (methodArguments.category!!) {
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_OPEN -> open(
                methodArguments.selector,
                result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_CLOSE -> close(
                methodArguments.uuid,
                result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_TORCH -> torch(
                methodArguments.uuid,
                methodArguments.torchState,
                result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_ZOOM -> zoom(
                methodArguments.uuid,
                methodArguments.zoomValue,
                result
            )
            Messages.MethodCategory.METHOD_CATEGORY_IMAGE_PROXY_CLOSE -> closeImageProxy(
                methodArguments.uuid,
                result
            )
            Messages.MethodCategory.UNRECOGNIZED -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ): Boolean {
        return if (requestCode != REQUEST_CODE) false
        else {
            val granted = grantResults.all { result ->
                result == PackageManager.PERMISSION_GRANTED
            }
            for (handler in requestPermissionsGrantedHandlers) {
                handler(granted)
            }
            requestPermissionsGrantedHandlers.clear()
            true
        }
    }

    private fun open(selector: Messages.CameraSelector, result: Result) {
        val activity = this.activityPluginBinding?.activity
        if (activity == null) result.error("Activity has been detached.")
        else {
            val context = flutterPluginBinding.applicationContext
            val runnable = Runnable {
                val future = ProcessCameraProvider.getInstance(context)
                val executor = ContextCompat.getMainExecutor(context)
                val listener = Runnable {
                    try {
                        val cameraProvider = future.get()
                        val lifecycleOwner = activity as LifecycleOwner
                        val cameraSelector = when (selector.facing!!) {
                            Messages.CameraFacing.CAMERA_FACING_BACK -> CameraSelector.DEFAULT_BACK_CAMERA
                            Messages.CameraFacing.CAMERA_FACING_FRONT -> CameraSelector.DEFAULT_FRONT_CAMERA
                            Messages.CameraFacing.UNRECOGNIZED -> throw NotImplementedError()
                        }
                        val preview = Preview.Builder()
                            .setTargetRotation(Surface.ROTATION_0)
                            .build()
                        val analysis = ImageAnalysis.Builder()
                            .setTargetRotation(Surface.ROTATION_0)
                            .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                            .build()
                        val camera = cameraProvider.bindToLifecycle(
                            lifecycleOwner,
                            cameraSelector,
                            preview,
                            analysis
                        )
                        val useCases = listOf(preview, analysis)
                        val nativeCamera = NativeCamera(camera, useCases)
                        val surfaceProvider = Preview.SurfaceProvider { request ->
                            val textureRegistry = flutterPluginBinding.textureRegistry
                            val textureEntry = textureRegistry.createSurfaceTexture()
                            val texture = textureEntry.surfaceTexture()
                            val width = request.resolution.width
                            val height = request.resolution.height
                            texture.setDefaultBufferSize(width, height)
                            val surface = Surface(texture)
                            val listener = Consumer<SurfaceRequest.Result> { }
                            request.provideSurface(surface, executor, listener)

                            // 开始监听状态变化
                            val owner = activity as LifecycleOwner
                            val torchStateObserver = Observer<Int> { state ->
                                val event = event {
                                    this.uuid = nativeCamera.uuid
                                    this.category =
                                        Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE
                                    this.torchState = state == TorchState.ON
                                }.toByteArray()
                                eventSink?.success(event)
                            }
                            camera.cameraInfo.torchState.observe(owner, torchStateObserver)
                            val zoomStateObserver = Observer<ZoomState> { state ->
                                val event = event {
                                    this.uuid = nativeCamera.uuid
                                    this.category =
                                        Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE
                                    this.zoomValue = state.zoomRatio.toDouble()
                                }.toByteArray()
                                eventSink?.success(event)
                            }
                            camera.cameraInfo.zoomState.observe(owner, zoomStateObserver)

                            // 保持 textureEntry 的引用，防止被 GC 回收
                            nativeCamera.textureEntry = textureEntry
                            nativeCameras[nativeCamera.uuid] = nativeCamera

                            val cameraValue = cameraValue {
                                this.uuid = nativeCamera.uuid
                                val cameraInfo = camera.cameraInfo
                                this.textureValue = textureValue {
                                    val degrees = cameraInfo.sensorRotationDegrees
                                    val size =
                                        if (degrees % 180 == 0) Size(width, height)
                                        else Size(height, width)
                                    this.id = textureEntry.id().toInt()
                                    this.width = size.width
                                    this.height = size.height
                                    this.quarterTurns = this@CameraXPlugin.quarterTurns
                                }
                                this.torchValue = torchValue {
                                    val state = cameraInfo.torchState.value!!
                                    this.available = cameraInfo.hasFlashUnit()
                                    this.state = state == TorchState.ON
                                }
                                this.zoomValue = zoomValue {
                                    val state = cameraInfo.zoomState.value!!
                                    this.minimum = state.minZoomRatio.toDouble()
                                    this.maximum = state.maxZoomRatio.toDouble()
                                    this.value = state.zoomRatio.toDouble()
                                }
                            }.toByteArray()
                            result.success(cameraValue)
                        }
                        preview.setSurfaceProvider(surfaceProvider)
                        val analysisExecutor = Executors.newSingleThreadExecutor()
                        val analyzer = ImageAnalysis.Analyzer { image ->
                            if (BuildConfig.DEBUG && image.format != ImageFormat.YUV_420_888) {
                                error("Assertion failed.")
                            }
                            val nativeImageProxy = NativeImageProxy(image)
                            nativeImageProxies[nativeImageProxy.uuid] = nativeImageProxy
                            val event = event {
                                this.uuid = nativeCamera.uuid
                                this.category =
                                    Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY
                                this.imageProxy = imageProxy {
                                    this.uuid = nativeImageProxy.uuid
                                    val rotationDegrees = when (activity.rotation) {
                                        Surface.ROTATION_0 -> 0
                                        Surface.ROTATION_90 -> 270
                                        Surface.ROTATION_180 -> 180
                                        Surface.ROTATION_270 -> 90
                                        else -> throw NotImplementedError()
                                    }
                                    val imageBytes: ByteArray
                                    val imageWidth: Int
                                    val imageHeight: Int
                                    when (image.imageInfo.rotationDegrees + rotationDegrees) {
                                        90 -> {
                                            imageBytes =
                                                rotate90(image.bytes, image.width, image.height)
                                            imageWidth = image.height
                                            imageHeight = image.width
                                        }
                                        180 -> {
                                            imageBytes =
                                                rotate180(
                                                    image.bytes,
                                                    image.width,
                                                    image.height
                                                )
                                            imageWidth = image.width
                                            imageHeight = image.height
                                        }
                                        270 -> {
                                            imageBytes =
                                                rotate270(
                                                    image.bytes,
                                                    image.width,
                                                    image.height
                                                )
                                            imageWidth = image.height
                                            imageHeight = image.width
                                        }
                                        else -> {
                                            imageBytes = image.bytes
                                            imageWidth = image.width
                                            imageHeight = image.height
                                        }
                                    }
                                    this.data = ByteString.copyFrom(imageBytes)
                                    this.width = imageWidth
                                    this.height = imageHeight
                                }
                            }.toByteArray()
                            activity.runOnUiThread { eventSink?.success(event) }
                        }
                        analysis.setAnalyzer(analysisExecutor, analyzer)
                    } catch (e: Exception) {
                        result.error(e)
                    }
                }
                future.addListener(listener, executor)
            }
            val permissions = arrayOf(Manifest.permission.CAMERA)
            val permissionsGranted = permissions.all { permission ->
                ContextCompat.checkSelfPermission(
                    context,
                    permission
                ) == PackageManager.PERMISSION_GRANTED
            }
            if (permissionsGranted) {
                runnable.run()
            } else {
                val handler = object : RequestPermissionsGrantedHandler {
                    override fun invoke(granted: Boolean) {
                        if (granted) {
                            runnable.run()
                        } else {
                            result.error("Permissions was denied by user.")
                        }
                    }
                }
                requestPermissionsGrantedHandlers.add(handler)
                ActivityCompat.requestPermissions(activity, permissions, REQUEST_CODE)
            }
        }
    }

    private fun close(key: String, result: Result) {
        val activity = this.activityPluginBinding?.activity
        if (activity == null) result.error("Activity has been detached.")
        else {
            val context = flutterPluginBinding.applicationContext
            val future = ProcessCameraProvider.getInstance(context)
            val executor = ContextCompat.getMainExecutor(context)
            val listener = Runnable {
                val cameraProvider = future.get()
                val nativeCamera = nativeCameras.remove(key)!!
                val camera = nativeCamera.value
                val textureEntry = nativeCamera.textureEntry
                val useCases = nativeCamera.useCases.toTypedArray()
                cameraProvider.unbind(*useCases)
                // 停止监听状态变化
                val owner = activity as LifecycleOwner
                camera.cameraInfo.zoomState.removeObservers(owner)
                camera.cameraInfo.torchState.removeObservers(owner)
                textureEntry.release()
                result.success()
            }
            future.addListener(listener, executor)
        }
    }

    private fun torch(key: String, state: Boolean, result: Result) {
        val camera = nativeCameras[key]!!.value
        camera.cameraControl.enableTorch(state)
        result.success()
    }

    private fun zoom(key: String, value: Double, result: Result) {
        val camera = nativeCameras[key]!!.value
        val zoom = value.toFloat()
        camera.cameraControl.setZoomRatio(zoom)
        result.success()
    }

    private fun closeImageProxy(key: String, result: Result) {
        val imageProxy = nativeImageProxies.remove(key)!!.value
        imageProxy.close()
        result.success()
    }
}
