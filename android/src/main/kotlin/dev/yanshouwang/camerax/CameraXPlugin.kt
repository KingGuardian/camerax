package dev.yanshouwang.camerax

import android.Manifest
import android.content.pm.PackageManager
import android.graphics.ImageFormat
import android.os.Handler
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
import dev.yanshouwang.camerax.message.*
import dev.yanshouwang.camerax.message.Messages.*
import dev.yanshouwang.camerax.message.Messages.CameraFacing.*
import dev.yanshouwang.camerax.message.Messages.CommandCategory.*
import dev.yanshouwang.camerax.message.Messages.EventCategory.*
import io.flutter.BuildConfig
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.util.*
import java.util.concurrent.Executors

typealias RequestPermissionsGrantedHandler = (granted: Boolean) -> Unit

/** CameraXPlugin */
class CameraXPlugin : FlutterPlugin, ActivityAware {
    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        private const val REQUEST_CODE = 3543
    }

    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null
    private var activityPluginBinding: ActivityPluginBinding? = null

    private val method by lazy {
        val messenger = flutterPluginBinding!!.binaryMessenger
        MethodChannel(messenger, "$NAMESPACE/method")
    }
    private val event by lazy {
        val messenger = flutterPluginBinding!!.binaryMessenger
        EventChannel(messenger, "$NAMESPACE/event")
    }
    private val handler by lazy {
        val looper = activityPluginBinding!!.activity.mainLooper
        Handler(looper)
    }

    private var quarterTurns: Int? = null
    private val quarterTurnsObserver by lazy {
        object : Thread() {
            override fun run() {
                super.run()
                val millis = 100L
                while (true) {
                    val activity = activityPluginBinding?.activity ?: break
                    val quarterTurns = activity.quarterTurns
                    if (this@CameraXPlugin.quarterTurns != quarterTurns) {
                        this@CameraXPlugin.quarterTurns = quarterTurns
                        // 设备方向变化
                        val event = event {
                            this.category = QUARTER_TURNS_CHANGED
                            this.quarterTurns = quarterTurns
                        }.toByteArray()
                        handler.post { events?.success(event) }
                    }
                    sleep(millis)
                }
            }
        }
    }

    private var events: EventChannel.EventSink? = null

    private val methodHandler by lazy {
        MethodChannel.MethodCallHandler { call, result ->
            val command = call.command
            when (command.category!!) {
                OPEN -> open(command.openArguments, result)
                CLOSE -> close(command.key, result)
                TORCH -> torch(command.key, command.torchState, result)
                ZOOM -> zoom(command.key, command.zoomValue, result)
                CLOSE_IMAGE_PROXY -> closeImageProxy(command.key, result)
                CommandCategory.UNRECOGNIZED -> result.notImplemented()
            }
        }
    }

    private val nativeCameras by lazy { mutableMapOf<String, NativeCamera>() }
    private val nativeImageProxies by lazy { mutableMapOf<String, NativeImageProxy>() }

    private fun open(openArguments: OpenArguments, result: MethodChannel.Result) {
        val flutterPluginBinding = this.flutterPluginBinding
        val activityPluginBinding = this.activityPluginBinding
        when {
            flutterPluginBinding == null -> result.error("Engine has been detached.")
            activityPluginBinding == null -> result.error("Activity has been detached.")
            else -> {
                val context = flutterPluginBinding.applicationContext
                val textureRegistry = flutterPluginBinding.textureRegistry
                val activity = activityPluginBinding.activity
                val runnable = Runnable {
                    val future = ProcessCameraProvider.getInstance(context)
                    val executor = ContextCompat.getMainExecutor(context)
                    val listener = Runnable {
                        try {
                            val cameraProvider = future.get()
                            val lifecycleOwner = activity as LifecycleOwner
                            val cameraSelector = when (openArguments.selector.facing!!) {
                                BACK -> CameraSelector.DEFAULT_BACK_CAMERA
                                FRONT -> CameraSelector.DEFAULT_FRONT_CAMERA
                                CameraFacing.UNRECOGNIZED -> throw NotImplementedError()
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
                                        this.key = nativeCamera.key
                                        this.category = TORCH_STATE_CHANGED
                                        this.torchState = state == TorchState.ON
                                    }.toByteArray()
                                    events?.success(event)
                                }
                                camera.cameraInfo.torchState.observe(owner, torchStateObserver)
                                val zoomStateObserver = Observer<ZoomState> { state ->
                                    val event = event {
                                        this.key = nativeCamera.key
                                        this.category = ZOOM_VALUE_CHANGED
                                        this.zoomValue = state.zoomRatio.toDouble()
                                    }.toByteArray()
                                    events?.success(event)
                                }
                                camera.cameraInfo.zoomState.observe(owner, zoomStateObserver)

                                // 保持 textureEntry 的引用，防止被 GC 回收
                                nativeCamera.textureEntry = textureEntry
                                nativeCameras[nativeCamera.key] = nativeCamera

                                val cameraValue = cameraValue {
                                    this.key = nativeCamera.key
                                    val cameraInfo = camera.cameraInfo
                                    this.textureValue = textureValue {
                                        val degrees = cameraInfo.sensorRotationDegrees
                                        val size =
                                            if (degrees % 180 == 0) Size(width, height)
                                            else Size(height, width)
                                        this.id = textureEntry.id().toInt()
                                        this.width = size.width
                                        this.height = size.height
                                        this.quarterTurns = this@CameraXPlugin.quarterTurns!!
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
                                nativeImageProxies[nativeImageProxy.key] = nativeImageProxy
                                val event = event {
                                    this.key = nativeCamera.key
                                    this.category = IMAGE_PROXY_RECEIVED
                                    this.image = imageProxy {
                                        this.key = nativeImageProxy.key
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
                                handler.post { events?.success(event) }
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
    }

    private fun close(key: String, result: MethodChannel.Result) {
        val flutterPluginBinding = this.flutterPluginBinding
        val activityPluginBinding = this.activityPluginBinding
        when {
            flutterPluginBinding == null -> result.error("Engine has been detached.")
            activityPluginBinding == null -> result.error("Activity has been detached.")
            else -> {
                val context = flutterPluginBinding.applicationContext
                val activity = activityPluginBinding.activity
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
    }

    private fun torch(key: String, state: Boolean, result: MethodChannel.Result) {
        val camera = nativeCameras[key]!!.value
        camera.cameraControl.enableTorch(state)
        result.success()
    }

    private fun zoom(key: String, value: Double, result: MethodChannel.Result) {
        val camera = nativeCameras[key]!!.value
        val zoom = value.toFloat()
        camera.cameraControl.setZoomRatio(zoom)
        result.success()
    }

    private fun closeImageProxy(key: String, result: MethodChannel.Result) {
        val imageProxy = nativeImageProxies.remove(key)!!.value
        imageProxy.close()
        result.success()
    }

    private val requestPermissionsGrantedHandlers by lazy { mutableListOf<RequestPermissionsGrantedHandler>() }

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
                for (handler in requestPermissionsGrantedHandlers) {
                    handler(granted)
                }
                requestPermissionsGrantedHandlers.clear()
                return@RequestPermissionsResultListener true
            }
        }
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding = binding
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityPluginBinding = binding
        activityPluginBinding!!.addRequestPermissionsResultListener(requestPermissionsResultListener)
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
        method.setMethodCallHandler(null)
        event.setStreamHandler(null)
        binding.removeRequestPermissionsResultListener(requestPermissionsResultListener)
        this.activityPluginBinding = null
    }
}
