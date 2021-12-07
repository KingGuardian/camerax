package dev.yanshouwang.camerax

import android.app.Activity
import android.util.Log
import android.util.Size
import android.view.Surface
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import io.flutter.view.TextureRegistry
import java.util.concurrent.Executor
import java.util.concurrent.Executors

class CameraController(
    private val activity: Activity,
    private val selector: CameraSelector,
    textureRegistry: TextureRegistry
) {
    private val textureEntry = textureRegistry.createSurfaceTexture()
    private lateinit var camera: Camera

    val cameraInfo get() = camera.cameraInfo

    fun open(
        analyzer: ImageAnalysis.Analyzer,
        onOpened: (textureId: Int, resolution: Size) -> Unit
    ) {
        Log.d(TAG, "open: ")
        val instance = ProcessCameraProvider.getInstance(activity)
        val executor = ContextCompat.getMainExecutor(activity)
        instance.addListener({
            val provider = instance.get()
            val lifecycleOwner = activity as LifecycleOwner
            val preview = Preview.Builder()
                .setTargetRotation(Surface.ROTATION_0)
                .build()
                .apply {
                    setSurfaceProvider { request ->
                        val texture = textureEntry.surfaceTexture()
                        val resolution = request.resolution
                        texture.setDefaultBufferSize(resolution.width, resolution.height)
                        val surface = Surface(texture)
                        request.provideSurface(surface, executor, { })
                        val textureId = textureEntry.id().toInt()
                        onOpened(textureId, resolution)
                    }
                }
            val analysis = ImageAnalysis.Builder()
                .setTargetRotation(Surface.ROTATION_0)
                .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .build()
                .apply { setAnalyzer(analyzer) }
            camera = provider.bindToLifecycle(lifecycleOwner, selector, preview, analysis)
        }, executor)
    }

    fun close(onClosed: () -> Unit) {
        Log.d(TAG, "close: ")
        val instance = ProcessCameraProvider.getInstance(activity)
        val executor = ContextCompat.getMainExecutor(activity)
        instance.addListener({
            val provider = instance.get()
            provider.unbindAll()
            onClosed()
        }, executor)
    }

    fun torch(state: Boolean) {
        camera.cameraControl.enableTorch(state)
    }

    fun zoom(ratio: Float) {
        camera.cameraControl.setZoomRatio(ratio)
    }

    fun dispose() {
        Log.d(TAG, "dispose: ")
        textureEntry.release()
    }
}