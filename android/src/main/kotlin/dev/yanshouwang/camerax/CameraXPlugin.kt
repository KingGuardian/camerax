package dev.yanshouwang.camerax

import android.Manifest
import android.content.pm.PackageManager
import android.graphics.ImageFormat
import android.view.Surface
import androidx.annotation.NonNull
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.ImageProxy
import androidx.camera.core.TorchState
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.protobuf.ByteString
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import io.flutter.view.TextureRegistry

/** CameraXPlugin */
class CameraXPlugin : FlutterPlugin, ActivityAware {
    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        private const val REQUEST_CODE = 3543
    }

    private lateinit var textureRegistry: TextureRegistry
    private lateinit var binding: ActivityPluginBinding

    private var eventSink: EventSink? = null

    private val methodCallHandler by lazy {
        MethodCallHandler { call, result ->
            val command = call.command
            when (command.category!!) {
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_CREATE -> {
                    createCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN -> {
                    openCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE -> {
                    closeCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH -> {
                    torchCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM -> {
                    zoomCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY -> {
                    focusAutomaticallyCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY -> {
                    focusManuallyCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_DISPOSE -> {
                    disposeCameraController(command, result)
                }
                Messages.CommandCategory.COMMAND_CATEGORY_IMAGE_PROXY_CLOSE -> {
                    closeImageProxy(command, result)
                }
                Messages.CommandCategory.UNRECOGNIZED -> result.notImplemented()
            }
        }
    }

    private val streamHandler by lazy {
        object : StreamHandler {
            override fun onListen(arguments: Any?, events: EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        }
    }

    private val requestPermissionResultListener by lazy {
        RequestPermissionsResultListener { requestCode, _, grantResults ->
            return@RequestPermissionsResultListener if (requestCode != REQUEST_CODE) false
            else {
                val granted = grantResults.all { result ->
                    result == PackageManager.PERMISSION_GRANTED
                }
                for (listener in requestPermissionResultListeners) {
                    listener(granted)
                }
                requestPermissionResultListeners.clear()
                true
            }
        }
    }

    private val requestPermissionResultListeners by lazy { mutableListOf<(granted: Boolean) -> Unit>() }

    private val quarterTurnsObserver by lazy {
        QuarterTurnsObserver { quarterTurns ->
            val event = event {
                this.category = Messages.EventCategory.EVENT_CATEGORY_QUARTER_TURNS
                this.quarterTurns = quarterTurns
            }.toByteArray()
            invokeOnMainThread { eventSink?.success(event) }
        }
    }

    private val indexedCameraControllers by lazy { mutableMapOf<String, IndexedCameraController>() }
    private val indexedImageProxies by lazy { mutableMapOf<String, IndexedImageProxy>() }

    override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
        textureRegistry = binding.textureRegistry
        val messenger = binding.binaryMessenger
        MethodChannel(messenger, "$NAMESPACE/method").setMethodCallHandler(methodCallHandler)
        EventChannel(messenger, "$NAMESPACE/event").setStreamHandler(streamHandler)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {}

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addRequestPermissionsResultListener(requestPermissionResultListener)
        quarterTurnsObserver.observe(binding.activity)
    }

    override fun onDetachedFromActivity() {
        for (indexedImageProxy in indexedImageProxies.values) {
            val imageProxy = indexedImageProxy.value
            imageProxy.close()
        }
        indexedImageProxies.clear()
        for (indexedCameraController in indexedCameraControllers.values) {
            val cameraController = indexedCameraController.value
            cameraController.dispose()
        }
        indexedCameraControllers.clear()
        quarterTurnsObserver.cancel()
        binding.removeRequestPermissionsResultListener(requestPermissionResultListener)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    private fun createCameraController(command: Messages.Command, result: Result) {
        val selector = command.selector.cameraxSelector
        val cameraController = CameraController(activity, selector, textureRegistry)
        val indexedCameraController = IndexedCameraController(cameraController)
        indexedCameraControllers[indexedCameraController.uuid] = indexedCameraController
        result.success(indexedCameraController.uuid)
    }

    private fun openCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val runnable = Runnable {
            val cameraController = indexedCameraControllers[uuid]!!.value
            val analyzer = object : ImageAnalysis.Analyzer {
                override fun analyze(imageProxy: ImageProxy) {
                    if (imageProxy.format != ImageFormat.YUV_420_888) {
                        val errorMessage = "Unsupported image format: ${imageProxy.format}"
                        eventSink?.error(TAG, errorMessage)
                    }
                    val indexedImageProxy = IndexedImageProxy(imageProxy)
                    indexedImageProxies[indexedImageProxy.uuid] = indexedImageProxy
                    val event = event {
                        this.category =
                            Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY
                        this.uuid = uuid
                        this.imageProxy = imageProxy {
                            this.uuid = indexedImageProxy.uuid
                            val imageBytes: ByteArray
                            val imageWidth: Int
                            val imageHeight: Int
                            val rotationDegrees =
                                (imageProxy.imageInfo.rotationDegrees - activity.rotationDegrees + 360) % 360
                            when (rotationDegrees) {
                                0 -> {
                                    imageBytes = imageProxy.bytes
                                    imageWidth = imageProxy.width
                                    imageHeight = imageProxy.height
                                }
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
                                    throw NotImplementedError()
                                }
                            }
                            this.data = ByteString.copyFrom(imageBytes)
                            this.width = imageWidth
                            this.height = imageHeight
                        }
                    }.toByteArray()
                    invokeOnMainThread { eventSink?.success(event) }
                }
            }
            cameraController.open(analyzer) { textureId, resolution ->
                val owner = activity as LifecycleOwner
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
                cameraController.cameraInfo.torchState.observe(owner, { torchState ->
                    val event = event {
                        this.category =
                            Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE
                        this.uuid = uuid
                        this.torchState = torchState == TorchState.ON
                    }.toByteArray()
                    eventSink?.success(event)
                })
                cameraController.cameraInfo.zoomState.observe(owner, { zoomState ->
                    val event = event {
                        this.category =
                            Messages.EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE
                        this.uuid = uuid
                        this.zoomValue = zoomState.zoomRatio.toDouble()
                    }.toByteArray()
                    eventSink?.success(event)
                })
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
            requestPermissionResultListeners.add { granted ->
                if (granted) {
                    runnable.run()
                } else {
                    result.error(TAG, "Permissions was denied by user.")
                }
            }
            ActivityCompat.requestPermissions(activity, permissions, REQUEST_CODE)
        }
    }

    private fun closeCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val cameraController = indexedCameraControllers[uuid]!!.value
        val owner = activity as LifecycleOwner
        cameraController.cameraInfo.torchState.removeObservers(owner)
        cameraController.cameraInfo.zoomState.removeObservers(owner)
        cameraController.close { result.success() }
    }

    private fun torchCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val state = command.torchState
        val cameraController = indexedCameraControllers[uuid]!!.value
        cameraController.torch(state)
        result.success()
    }

    private fun zoomCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val ratio = command.zoomValue.toFloat()
        val cameraController = indexedCameraControllers[uuid]!!.value
        cameraController.zoom(ratio)
        result.success()
    }

    private fun focusAutomaticallyCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val cameraController = indexedCameraControllers[uuid]!!.value
        cameraController.focusAutomatically()
        result.success()
    }

    private fun focusManuallyCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val size = command.size
        val offset = command.offset
        val cameraController = indexedCameraControllers[uuid]!!.value
        val width = size.width.toFloat()
        val height = size.height.toFloat()
        val x = offset.x.toFloat()
        val y = offset.y.toFloat()
        cameraController.focusManually(width, height, x, y)
        result.success()
    }

    private fun disposeCameraController(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val cameraController = indexedCameraControllers.remove(uuid)!!.value
        cameraController.dispose()
        result.success()
    }

    private fun closeImageProxy(command: Messages.Command, result: Result) {
        val uuid = command.uuid
        val imageProxy = indexedImageProxies.remove(uuid)!!.value
        imageProxy.close()
        result.success()
    }

    private fun invokeOnMainThread(action: Runnable) {
        binding.activity.runOnUiThread(action)
    }
}
