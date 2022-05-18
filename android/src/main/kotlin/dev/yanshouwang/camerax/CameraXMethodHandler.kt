package dev.yanshouwang.camerax

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.util.Log
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import dev.yanshouwang.camerax.messages.*
import dev.yanshouwang.camerax.messages.Messages.*
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.*
import io.flutter.view.TextureRegistry

class CameraXMethodHandler(
    private val binding: ActivityPluginBinding,
    private val messenger: BinaryMessenger,
    private val textureRegistry: TextureRegistry
) : MethodChannel.MethodCallHandler {

    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        private const val REQUEST_CODE = 3543
    }

    private val activity: Activity = binding.activity

    private val methodChannel: MethodChannel = MethodChannel(messenger, "$NAMESPACE/method")
    private val eventChannel: EventChannel = EventChannel(messenger, "$NAMESPACE/event")
    private var eventSink: EventChannel.EventSink? = null

    private var orientationService : QuarterTurnsObserver? = null

    private var cameraController: CameraController? = null

    private val requestPermissionResultListeners by lazy { mutableListOf<(granted: Boolean) -> Unit>() }
    private val requestPermissionResultListener by lazy {
        PluginRegistry.RequestPermissionsResultListener { requestCode, _, grantResults ->
            return@RequestPermissionsResultListener if (requestCode != CameraXPlugin.REQUEST_CODE) false
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

    init {
        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                cameraController?.eventSink = eventSink
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val command = call.command
        when (command.category!!) {
            CommandCategory.COMMAND_CATEGORY_GET_QUARTER_TURNS -> {
                //获取屏幕旋转角度
                handleGetQuarterTurns(result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_REQUEST_PERMISSION -> {
                handleRequestPermission(result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_BIND -> {
                //处理绑定相机
                handleBind(command.cameraControllerBindArguments, result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_UNBIND -> {
                handleUnbind(command.cameraControllerUnbindArguments, result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH -> {
                handleTorch(command.cameraControllerTorchArguments, result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM -> {
                handleZoom(command.cameraControllerZoomArguments, result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY -> {
                handleFocusAutomatically(command.cameraControllerFocusAutomaticallyArguments, result)
            }
            CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY -> {
                 handleFocusManually(command.cameraControllerFocusManuallyArguments, result)
            }
            CommandCategory.COMMAND_CATEGORY_IMAGE_PROXY_CLOSE -> {
                handleImageProxy(command.imageProxyCloseArguments, result)
            }
            CommandCategory.UNRECOGNIZED -> result.notImplemented()
        }
    }

    fun startListen() {
        binding.addRequestPermissionsResultListener(requestPermissionResultListener)
    }

    fun stopListen() {
        val activity = binding.activity
        val listenable = ProcessCameraProvider.getInstance(activity)
        val mainExecutor = ContextCompat.getMainExecutor(activity)
        listenable.addListener({
            try {
                val provider = listenable.get()
                provider.unbindAll()
                val textureEntry = cameraController?.textureEntry
                textureEntry?.release()
            } catch (e: Exception) {
                Log.e(TAG, "Clear failed: ${e.message}", e)
            }
        }, mainExecutor)

        binding.removeRequestPermissionsResultListener(requestPermissionResultListener)
        methodChannel.setMethodCallHandler(null)
    }

    //处理获取屏幕转动角度
    private fun handleGetQuarterTurns(result: MethodChannel.Result) {
        if (orientationService == null) {
            initOrientationService()
        }
        sendOrientationReplyData(result)
    }

    private fun handleRequestPermission(result: MethodChannel.Result) {
        val permissions = arrayOf(Manifest.permission.CAMERA)

        //获取权限状态
        val permissionsGranted = permissions.all { permission ->
            ContextCompat.checkSelfPermission(
                activity,
                permission
            ) == PackageManager.PERMISSION_GRANTED
        }

        fun runnable(granted: Boolean) {
            val reply = reply {
                this.cameraControllerRequestPermissionArguments =
                    cameraControllerRequestPermissionReplyArguments {
                        this.granted = granted
                    }
            }.toByteArray()
            result.success(reply)
        }
        if (permissionsGranted) {
            runnable(permissionsGranted)
        } else {
            //如果没有权限，则进行申请
            requestPermissionResultListeners.add { granted -> runnable(granted) }
            ActivityCompat.requestPermissions(activity, permissions, CameraXPlugin.REQUEST_CODE)
        }
    }

    //绑定相机，这里根据参数对相机进行初始化
    private fun handleBind(arguments: CameraControllerBindCommandArguments, result: MethodChannel.Result) {

        if (orientationService == null) {
            initOrientationService()
        }
        orientationService?.start()
        val faceSelector = arguments.selector
//        arguments.
        //这里的数据发送，交给cameraController去做吧

        cameraController = CameraController(activity, textureRegistry.createSurfaceTexture(), faceSelector)
        cameraController?.bind(result)
    }

    private fun handleUnbind(arguments: CameraControllerUnbindCommandArguments, result: MethodChannel.Result) {
        cameraController?.unBind(arguments, result)
        cameraController = null

        orientationService?.stop()
    }

    private fun handleTorch(arguments: CameraControllerTorchCommandArguments, result: MethodChannel.Result) {
        cameraController?.handleTorch(arguments, result)
    }

    private fun handleZoom(arguments: CameraControllerZoomCommandArguments, result: MethodChannel.Result) {
        cameraController?.handleZoom(arguments, result)
    }

    private fun handleFocusAutomatically(arguments: CameraControllerFocusAutomaticallyCommandArguments, result: MethodChannel.Result) {
        cameraController?.handleFocusAutomatically(arguments, result)
    }

    private fun handleFocusManually(arguments: CameraControllerFocusManuallyCommandArguments, result: MethodChannel.Result) {
        cameraController?.handleFocusManually(arguments, result)
    }

    private fun handleImageProxy(arguments: ImageProxyCloseCommandArguments, result: MethodChannel.Result) {
        cameraController?.handleImageProxy(arguments, result)
    }

    private fun initOrientationService() {
        orientationService = QuarterTurnsObserver(activity, false, 0) { orientation ->
            sendOrientationEventData(orientation)
        }
    }

    private fun sendOrientationReplyData(result: MethodChannel.Result) {
        //直接获取数据发送
        val reply = reply {
            this.getQuarterTurnsArguments = getQuarterTurnsReplyArguments {
                this.quarterTurns = orientationService?.deviceOrientation ?: 0
            }
        }.toByteArray()
        result.success(reply)
    }

    private fun sendOrientationEventData(orientation: Int) {
        //直接获取数据发送
        val event = event {
            this.quarterTurnsChangedArguments = quarterTurnsChangedEventArguments {
                this.quarterTurns = orientation
            }
        }.toByteArray()
        invokeOnMainThread { eventSink?.success(event) }
    }

    private fun invokeOnMainThread(action: Runnable) {
        binding.activity.runOnUiThread(action)
    }
}