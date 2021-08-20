package dev.yanshouwang.camerax

import android.Manifest
import android.content.pm.PackageManager
import android.os.Handler
import android.util.Size
import android.view.Surface
import androidx.annotation.NonNull
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import dev.yanshouwang.camerax.communication.Communication
import dev.yanshouwang.camerax.communication.Communication.CameraFacing.*
import dev.yanshouwang.camerax.communication.Communication.MessageCategory.*
import dev.yanshouwang.camerax.communication.Communication.MessageCategory.UNRECOGNIZED
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.util.*

typealias RequestHandler = (granted: Boolean) -> Unit

/** CameraXPlugin */
class CameraXPlugin : FlutterPlugin, ActivityAware {
    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        private const val REQUEST_CODE = 3543
    }

    private var bindingOfFlutter: FlutterPlugin.FlutterPluginBinding? = null
    private var bindingOfActivity: ActivityPluginBinding? = null

    private val method by lazy {
        val messenger = bindingOfFlutter!!.binaryMessenger
        return@lazy MethodChannel(messenger, "$NAMESPACE/method")
    }
    private val event by lazy {
        val messenger = bindingOfFlutter!!.binaryMessenger
        return@lazy EventChannel(messenger, "$NAMESPACE/event")
    }
    private val handler by lazy {
        val mainLooper = bindingOfActivity!!.activity.mainLooper
        return@lazy Handler(mainLooper)
    }

    private var rotation: Int? = null

    private val watcher by lazy {
        object : Thread() {
            override fun run() {
                super.run()
                val interval = 100L
                while (true) {
                    val activity = bindingOfActivity?.activity ?: break
                    val rotation = activity.rotation
                    if (this@CameraXPlugin.rotation != rotation) {
                        this@CameraXPlugin.rotation = rotation
                        // 设备方向变化
                        val displayRotation = Communication.DisplayRotation.forNumber(rotation)
                        val message = Communication.Message.newBuilder()
                            .setCategory(DEVICE_ROTATION_CHANGED)
                            .setRotation(displayRotation)
                            .build()
                            .toByteArray()
                        handler.post { events?.success(message) }
                    }
                    sleep(interval)
                }
            }
        }
    }

    private var events: EventChannel.EventSink? = null

    private val methodHandler by lazy {
        MethodChannel.MethodCallHandler { call, result ->
            val message = call.message
            when (message.category!!) {
                CAMERA_CONTROLLER_BIND -> bind(message.bindArgs, result)
                CAMERA_CONTROLLER_UNBIND -> unbind(message.unbindArgs, result)
                CAMERA_CONTROLLER_TORCH -> torch(message.torchArgs, result)
                CAMERA_ARGS_CHANGED -> result.notImplemented()
                TORCH_STATE_CHANGED -> result.notImplemented()
                UNRECOGNIZED -> result.notImplemented()
                DEVICE_GET_ROTATION -> result.success(rotation)
                DEVICE_ROTATION_CHANGED -> result.notImplemented()
            }
        }
    }

    private fun torch(torchArgs: Communication.TorchArgs, result: MethodChannel.Result) {
        val camera = keepers[torchArgs.key]!!.camera
        camera.cameraControl.enableTorch(torchArgs.state)
        result.success()
    }

    private fun unbind(unbindArgs: Communication.UnbindArgs, result: MethodChannel.Result) {
        val bindingOfFlutter = this.bindingOfFlutter
        if (bindingOfFlutter == null) {
            result.error("Engine has been detached.")
        } else {
            val context = bindingOfFlutter.applicationContext
            val cameraProviderFuture = ProcessCameraProvider.getInstance(context)
            val mainExecutor = ContextCompat.getMainExecutor(context)
            val listener = Runnable {
                val cameraProvider = cameraProviderFuture.get()
                val keeper = keepers.remove(unbindArgs.key)!!
                cameraProvider.unbind(*keeper.useCases)
            }
            cameraProviderFuture.addListener(listener, mainExecutor)
        }
    }

    private fun bind(bindArgs: Communication.BindArgs, result: MethodChannel.Result) {
        val bindingOfFlutter = this.bindingOfFlutter
        val bindingOfActivity = this.bindingOfActivity
        if (bindingOfFlutter == null) {
            result.error("Engine has been detached.")
        } else if (bindingOfActivity == null) {
            result.error("Activity has been detached.")
        } else {
            val context = bindingOfFlutter.applicationContext
            val activity = bindingOfActivity.activity
            val runnable = Runnable {
                val cameraProviderFuture = ProcessCameraProvider.getInstance(context)
                val mainExecutor = ContextCompat.getMainExecutor(context)
                val listener = {
                    try {
                        val key = UUID.randomUUID().toString()
                        val cameraProvider = cameraProviderFuture.get()
                        val lifecycleOwner = activity as LifecycleOwner
                        val cameraSelector = when (bindArgs.selector.facing!!) {
                            FRONT -> CameraSelector.DEFAULT_FRONT_CAMERA
                            BACK -> CameraSelector.DEFAULT_BACK_CAMERA
                            Communication.CameraFacing.UNRECOGNIZED -> throw NotImplementedError()
                        }
                        val surfaceProvider = Preview.SurfaceProvider { request ->
                            val textureRegistry = bindingOfFlutter.textureRegistry
                            val textureEntry = textureRegistry.createSurfaceTexture()
                            val texture = textureEntry.surfaceTexture()
                            val width = request.resolution.width
                            val height = request.resolution.height
                            texture.setDefaultBufferSize(width, height)
                            val surface = Surface(texture)
                            request.provideSurface(surface, mainExecutor, {})
                            val textureId = textureEntry.id().toInt()
                            val camera = keepers[key]!!.camera
                            val sensorDegrees = camera.cameraInfo.sensorRotationDegrees
                            val size =
                                if (sensorDegrees % 180 == 0) Size(width, height)
                                else Size(height, width)
                            val builderForSize = Communication.CameraSize.newBuilder()
                                .setWidth(size.width)
                                .setHeight(size.height)
                            val builderForArgs = Communication.CameraArgs.newBuilder()
                                .setTextureId(textureId)
                                .setSize(builderForSize)
                                .setHasTorch(camera.hasTorch)
                            val binding = Communication.CameraBinding.newBuilder()
                                .setKey(key)
                                .setCameraArgs(builderForArgs)
                                .build()
                                .toByteArray()
                            result.success(binding)
                        }
                        val preview = Preview.Builder()
                            .build()
                            .apply { setSurfaceProvider(surfaceProvider) }
                        val useCases = arrayOf<UseCase>(preview)
                        val camera = cameraProvider.bindToLifecycle(
                            lifecycleOwner,
                            cameraSelector,
                            *useCases,
                        )
                        keepers[key] = CameraKeeper(camera, useCases)
                    } catch (e: Exception) {
                        result.error(e)
                    }
                }
                cameraProviderFuture.addListener(listener, mainExecutor)
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
                val handler = object : RequestHandler {
                    override fun invoke(granted: Boolean) {
                        if (granted) {
                            runnable.run()
                        } else {
                            result.error("Permissions was denied by user.")
                        }
                    }
                }
                requestHandlers.add(handler)
                ActivityCompat.requestPermissions(activity, permissions, REQUEST_CODE)
            }
        }
    }

    private val requestHandlers by lazy { mutableListOf<RequestHandler>() }

    private val streamHandler by lazy {
        object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                this@CameraXPlugin.events = events
            }

            override fun onCancel(arguments: Any?) {
                this@CameraXPlugin.events = null
            }
        }
    }
    private val requestPermissionsResultListener by lazy {
        PluginRegistry.RequestPermissionsResultListener { requestCode, _, results ->
            if (requestCode != REQUEST_CODE) {
                return@RequestPermissionsResultListener false
            } else {
                val granted = results.all { result ->
                    result == PackageManager.PERMISSION_GRANTED
                }
                for (handler in requestHandlers) {
                    handler(granted)
                }
                requestHandlers.clear()
                return@RequestPermissionsResultListener true
            }
        }
    }

    private val keepers by lazy { mutableMapOf<String, CameraKeeper>() }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        bindingOfFlutter = binding
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        bindingOfFlutter = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        bindingOfActivity = binding
        bindingOfActivity!!.addRequestPermissionsResultListener(requestPermissionsResultListener)
        method.setMethodCallHandler(methodHandler)
        event.setStreamHandler(streamHandler)
        rotation = binding.activity.rotation
        watcher.start()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        keepers.clear()
        method.setMethodCallHandler(null)
        event.setStreamHandler(null)
        bindingOfActivity!!.removeRequestPermissionsResultListener(requestPermissionsResultListener)
        bindingOfActivity = null
    }
}
