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
import androidx.lifecycle.Observer
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
        MethodChannel(messenger, "$NAMESPACE/method")
    }
    private val event by lazy {
        val messenger = bindingOfFlutter!!.binaryMessenger
        EventChannel(messenger, "$NAMESPACE/event")
    }
    private val handler by lazy {
        val mainLooper = bindingOfActivity!!.activity.mainLooper
        Handler(mainLooper)
    }

    private var quarterTurns: Int? = null

    private val quarterTurnsObserver by lazy {
        object : Thread() {
            override fun run() {
                super.run()
                val interval = 100L
                while (true) {
                    val activity = bindingOfActivity?.activity ?: break
                    val quarterTurns = activity.quarterTurns
                    if (this@CameraXPlugin.quarterTurns != quarterTurns) {
                        this@CameraXPlugin.quarterTurns = quarterTurns
                        // 设备方向变化
                        for (keeper in keepers) {
                            val key = keeper.key
                            val textureEntry = keeper.value.textureEntry
                            val builderForTextureInfo = Communication.TextureInfo.newBuilder()
                                .setId(textureEntry.id())
                            val message = Communication.Message.newBuilder()
                                .setCategory(TEXTURE_INFO_EVENT)
                                .setKey()
                                .setTextureInfo(builderForTextureInfo)
                                .build()
                                .toByteArray()
                            handler.post { events?.success(message) }
                        }
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
                BIND -> bind(message.key, message.bindArgs, result)
                UNBIND -> unbind(message.key, result)
                TEXTURE_INFO -> textureInfo(message.key, result)
                TEXTURE_INFO_EVENT -> result.notImplemented()
                TORCH -> torch(message.key, message.torchState, result)
                TORCH_EVENT -> result.notImplemented()
                ANALYSIS_EVENT -> result.notImplemented()
                UNRECOGNIZED -> result.notImplemented()
            }
        }
    }

    private fun bind(key: Int, bindArgs: Communication.BindArgs, result: MethodChannel.Result) {
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
                val listener = Runnable {
                    try {
                        val cameraProvider = cameraProviderFuture.get()
                        val lifecycleOwner = activity as LifecycleOwner
                        val cameraSelector = when (bindArgs.selector.facing!!) {
                            FRONT -> CameraSelector.DEFAULT_FRONT_CAMERA
                            BACK -> CameraSelector.DEFAULT_BACK_CAMERA
                            Communication.CameraFacing.UNRECOGNIZED -> throw NotImplementedError()
                        }
                        val surfaceProvider = Preview.SurfaceProvider { request ->
                            val keeper = keepers[key]!!
                            val camera = keeper.camera
                            val textureEntry = keeper.textureEntry
                            val texture = textureEntry.surfaceTexture()
                            val width = request.resolution.width
                            val height = request.resolution.height
                            texture.setDefaultBufferSize(width, height)
                            val surface = Surface(texture)
                            request.provideSurface(surface, mainExecutor, { })
                            val hasTorch = camera.cameraInfo.hasFlashUnit()
                            val cameraInfo = Communication.CameraInfo.newBuilder()
                                .setHasTorch(hasTorch)
                                .build()
                                .toByteArray()
                            result.success(cameraInfo)
                            // TEXTURE_INFO_EVENT
                            val textureId = textureEntry.id().toInt()
                            val sensorDegrees = camera.cameraInfo.sensorRotationDegrees
                            val size =
                                if (sensorDegrees % 180 == 0) Size(width, height)
                                else Size(height, width)
                            val builderForSize = Communication.TextureSize.newBuilder()
                                .setWidth(size.width)
                                .setHeight(size.height)
                            val builderForTextureInfo = Communication.TextureInfo.newBuilder()
                                .setId(textureId)
                                .setSize(builderForSize)
                                .setQuarterTurns(quarterTurns!!)
                            val message = Communication.Message.newBuilder()
                                .setKey(key)
                                .setCategory(TEXTURE_INFO_EVENT)
                                .setTextureInfo(builderForTextureInfo)
                                .build()
                                .toByteArray()
                            events?.success(message)
                        }
                        val preview = Preview.Builder()
                            .build()
                            .apply { setSurfaceProvider(surfaceProvider) }
                        val camera = cameraProvider.bindToLifecycle(
                            lifecycleOwner,
                            cameraSelector,
                            preview
                        )
                        // TORCH_EVENT
                        val owner = activity as LifecycleOwner
                        val observer = Observer<Int> { data ->
                            val torchState = data == TorchState.ON
                            val message = Communication.Message.newBuilder()
                                .setKey(key)
                                .setTorchState(torchState)
                                .build()
                                .toByteArray()
                            events?.success(message)
                        }
                        camera.cameraInfo.torchState.observe(owner, observer)
                        val useCases = listOf<UseCase>(preview)
                        val textureRegistry = bindingOfFlutter.textureRegistry
                        val textureEntry = textureRegistry.createSurfaceTexture()
                        // 保持 textureEntry 的引用，防止被 GC 回收
                        keepers[key] = CameraKeeper(camera, useCases, textureEntry)
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

    private fun unbind(key: Int, result: MethodChannel.Result) {
        val bindingOfFlutter = this.bindingOfFlutter
        if (bindingOfFlutter == null) {
            result.error("Engine has been detached.")
        } else {
            val context = bindingOfFlutter.applicationContext
            val cameraProviderFuture = ProcessCameraProvider.getInstance(context)
            val mainExecutor = ContextCompat.getMainExecutor(context)
            val listener = Runnable {
                val cameraProvider = cameraProviderFuture.get()
                val keeper = keepers.remove(key)!!
                val useCases = keeper.useCases.toTypedArray()
                cameraProvider.unbind(*useCases)
            }
            cameraProviderFuture.addListener(listener, mainExecutor)
        }
    }

    private fun textureInfo(key: Int, result: MethodChannel.Result) {

    }

    private fun torch(key: Int, state: Boolean, result: MethodChannel.Result) {
        val camera = keepers[key]!!.camera
        camera.cameraControl.enableTorch(state)
        result.success()
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

    private val keepers by lazy { mutableMapOf<Int, CameraKeeper>() }

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
        quarterTurns = binding.activity.quarterTurns
        quarterTurnsObserver.start()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        for (keeper in keepers.values) {
            val owner = bindingOfActivity!!.activity as LifecycleOwner
            keeper.camera.cameraInfo.torchState.removeObservers(owner)
        }
        keepers.clear()
        method.setMethodCallHandler(null)
        event.setStreamHandler(null)
        bindingOfActivity!!.removeRequestPermissionsResultListener(requestPermissionsResultListener)
        bindingOfActivity = null
    }
}
