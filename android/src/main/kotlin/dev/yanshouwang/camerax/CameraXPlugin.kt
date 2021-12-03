package dev.yanshouwang.camerax

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.graphics.ImageFormat
import android.view.Surface
import androidx.annotation.NonNull
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.protobuf.ByteString
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
import io.flutter.view.TextureRegistry
import java.util.concurrent.Executors

/** CameraXPlugin */
class CameraXPlugin : FlutterPlugin, ActivityAware, MethodCallHandler, StreamHandler,
    RequestPermissionsResultListener {
    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        private const val REQUEST_CODE = 3543
    }

    private lateinit var textureRegistry: TextureRegistry
    private lateinit var activity: Activity

    private var eventSink: EventSink? = null

    private fun invokeOnMainThread(action: Runnable) {
        activity.runOnUiThread(action)
    }

    private val quarterTurnsObserver by lazy {
        QuarterTurnsObserver { quarterTurns ->
            val event = event {
                this.category = Messages.EventCategory.EVENT_CATEGORY_QUARTER_TURNS
                this.quarterTurns = quarterTurns
            }.toByteArray()
            invokeOnMainThread { eventSink?.success(event) }
        }
    }

    private val requestPermissionsGrantedHandlers by lazy { mutableListOf<(granted: Boolean) -> Unit>() }

    private val indexedCameraControllers by lazy { mutableMapOf<String, IndexedCameraController>() }
    private val indexedImageProxies by lazy { mutableMapOf<String, IndexedImageProxy>() }

    override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
        textureRegistry = binding.textureRegistry
        val messenger = binding.binaryMessenger
        MethodChannel(messenger, "$NAMESPACE/method").setMethodCallHandler(this)
        EventChannel(messenger, "$NAMESPACE/event").setStreamHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addRequestPermissionsResultListener(this)
        quarterTurnsObserver.observe(binding.activity)
    }

    override fun onDetachedFromActivity() {
        for (indexedImageProxy in indexedImageProxies.values) {
            val imageProxy = indexedImageProxy.value
            imageProxy.close()
        }
        indexedImageProxies.clear()
        indexedCameraControllers.clear()
        quarterTurnsObserver.cancel()
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
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_CREATE -> create(
                methodArguments.selector, result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_OPEN -> open(
                methodArguments.uuid, result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_CLOSE -> close(
                methodArguments.uuid, result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_TORCH -> torch(
                methodArguments.uuid, methodArguments.torchState, result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_ZOOM -> zoom(
                methodArguments.uuid, methodArguments.zoomValue, result
            )
            Messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_DISPOSE -> dispose(
                methodArguments.uuid, result
            )
            Messages.MethodCategory.METHOD_CATEGORY_IMAGE_PROXY_CLOSE -> closeImageProxy(
                methodArguments.uuid, result
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

    private fun create(selector: Messages.CameraSelector, result: Result) {
        val selector1 = when (selector.facing!!) {
            Messages.CameraFacing.CAMERA_FACING_BACK -> CameraSelector.DEFAULT_BACK_CAMERA
            Messages.CameraFacing.CAMERA_FACING_FRONT -> CameraSelector.DEFAULT_FRONT_CAMERA
            Messages.CameraFacing.UNRECOGNIZED -> throw NotImplementedError()
        }
        val cameraController = CameraController(activity, selector1, textureRegistry)
        val indexedCameraController = IndexedCameraController(cameraController)
        indexedCameraControllers[indexedCameraController.uuid] = indexedCameraController
        result.success(indexedCameraController.uuid)
    }

    private fun open(uuid: String, result: Result) {
        val runnable = Runnable {
            val cameraController = indexedCameraControllers[uuid]!!.value
            cameraController.open { textureId, resolution ->
                val owner = activity as LifecycleOwner
                cameraController.cameraInfo.torchState.observe(owner, { torchState ->
                    val event = event {
                        this.uuid = uuid
                        this.category =
                            Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE
                        this.torchState = torchState == TorchState.ON
                    }.toByteArray()
                    eventSink?.success(event)
                })
                cameraController.cameraInfo.zoomState.observe(owner, { zoomState ->
                    val event = event {
                        this.uuid = uuid
                        this.category =
                            Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE
                        this.zoomValue = zoomState.zoomRatio.toDouble()
                    }.toByteArray()
                    eventSink?.success(event)
                })
                val executor = Executors.newSingleThreadExecutor()
                cameraController.setAnalyzer(executor, { imageProxy ->
                    if (imageProxy.format != ImageFormat.YUV_420_888) {
                        val errorMessage = "Unsupported image format: ${imageProxy.format}"
                        eventSink?.error(TAG, errorMessage)
                    }
                    val indexedImageProxy = IndexedImageProxy(imageProxy)
                    indexedImageProxies[indexedImageProxy.uuid] = indexedImageProxy
                    val event = event {
                        this.uuid = indexedImageProxy.uuid
                        this.category =
                            Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY
                        this.imageProxy = imageProxy {
                            this.uuid = indexedImageProxy.uuid
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
                            when (imageProxy.imageInfo.rotationDegrees + rotationDegrees) {
                                90 -> {
                                    imageBytes = rotate90(
                                        imageProxy.bytes,
                                        imageProxy.width,
                                        imageProxy.height
                                    )
                                    imageWidth = imageProxy.height
                                    imageHeight = imageProxy.width
                                }
                                180 -> {
                                    imageBytes = rotate180(
                                        imageProxy.bytes,
                                        imageProxy.width,
                                        imageProxy.height
                                    )
                                    imageWidth = imageProxy.width
                                    imageHeight = imageProxy.height
                                }
                                270 -> {
                                    imageBytes = rotate270(
                                        imageProxy.bytes,
                                        imageProxy.width,
                                        imageProxy.height
                                    )
                                    imageWidth = imageProxy.height
                                    imageHeight = imageProxy.width
                                }
                                else -> {
                                    imageBytes = imageProxy.bytes
                                    imageWidth = imageProxy.width
                                    imageHeight = imageProxy.height
                                }
                            }
                            this.data = ByteString.copyFrom(imageBytes)
                            this.width = imageWidth
                            this.height = imageHeight
                        }
                    }.toByteArray()
                    invokeOnMainThread { eventSink?.success(event) }
                })
                val cameraInfo = cameraController.cameraInfo
                val cameraValue = cameraValue {
                    this.textureValue = textureValue {
                        this.id = textureId
                        if (cameraInfo.sensorRotationDegrees % 180 == 0) {
                            this.width = resolution.width
                            this.height = resolution.height
                        } else {
                            this.width = resolution.height
                            this.height = resolution.width
                        }
                        this.quarterTurns = quarterTurnsObserver.quarterTurns
                    }
                    this.torchValue = torchValue {
                        this.available = cameraInfo.hasFlashUnit()
                        this.state = cameraInfo.torchState.value == TorchState.ON
                    }
                    this.zoomValue = zoomValue {
                        val zoomState = cameraInfo.zoomState.value!!
                        this.minimum = zoomState.minZoomRatio.toDouble()
                        this.maximum = zoomState.maxZoomRatio.toDouble()
                        this.value = zoomState.zoomRatio.toDouble()
                    }
                }.toByteArray()
                result.success(cameraValue)
            }
        }
        val permissions = arrayOf(Manifest.permission.CAMERA)
        val permissionsGranted = permissions.all { permission ->
            ContextCompat.checkSelfPermission(
                activity,
                permission
            ) == PackageManager.PERMISSION_GRANTED
        }
        if (permissionsGranted) {
            runnable.run()
        } else {
            requestPermissionsGrantedHandlers.add { granted ->
                if (granted) {
                    runnable.run()
                } else {
                    result.error(TAG, "Permissions was denied by user.")
                }
            }
            ActivityCompat.requestPermissions(activity, permissions, REQUEST_CODE)
        }
    }

    private fun close(uuid: String, result: Result) {
        val cameraController = indexedCameraControllers[uuid]!!.value
        cameraController.close { result.success() }
    }

    private fun torch(uuid: String, state: Boolean, result: Result) {
        val cameraController = indexedCameraControllers[uuid]!!.value
        cameraController.torch(state)
        result.success()
    }

    private fun zoom(uuid: String, value: Double, result: Result) {
        val cameraController = indexedCameraControllers[uuid]!!.value
        val ratio = value.toFloat()
        cameraController.zoom(ratio)
        result.success()
    }

    private fun dispose(uuid: String, result: Result) {
        val cameraController = indexedCameraControllers.remove(uuid)!!.value
        cameraController.dispose { result.success() }
    }

    private fun closeImageProxy(key: String, result: Result) {
        val imageProxy = indexedImageProxies.remove(key)!!.value
        imageProxy.close()
        result.success()
    }
}
