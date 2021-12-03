package dev.yanshouwang.camerax

import android.app.Activity
import android.util.Size
import android.view.Surface
import androidx.camera.core.Camera
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.Preview
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import io.flutter.view.TextureRegistry
import java.util.concurrent.Executor

class CameraController(
    private val activity: Activity,
    private val selector: CameraSelector,
    textureRegistry: TextureRegistry
) {
    private val textureEntry = textureRegistry.createSurfaceTexture()
    private lateinit var preview: Preview
    private lateinit var analysis: ImageAnalysis
    private lateinit var camera: Camera

    val cameraInfo get() = camera.cameraInfo

    private var opened: Boolean = false

    fun open(onOpened: (textureId: Int, resolution: Size) -> Unit) {
        val instance = ProcessCameraProvider.getInstance(activity)
        val executor = ContextCompat.getMainExecutor(activity)
        instance.addListener({
            val provider = instance.get()
            val lifecycleOwner = activity as LifecycleOwner
            preview = Preview.Builder()
                .setTargetRotation(Surface.ROTATION_0)
                .build()
            analysis = ImageAnalysis.Builder()
                .setTargetRotation(Surface.ROTATION_0)
                .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .build()
            val surfaceProvider = Preview.SurfaceProvider { request ->
                val texture = textureEntry.surfaceTexture()
                val resolution = request.resolution
                texture.setDefaultBufferSize(resolution.width, resolution.height)
                val surface = Surface(texture)
                request.provideSurface(surface, executor, { })
                val textureId = textureEntry.id().toInt()
                opened = true
                onOpened(textureId, resolution)
            }
            preview.setSurfaceProvider(surfaceProvider)
            camera = provider.bindToLifecycle(lifecycleOwner, selector, preview, analysis)
        }, executor)
    }

    fun setAnalyzer(executor: Executor, analyzer: ImageAnalysis.Analyzer) {
        analysis.setAnalyzer(executor, analyzer)
    }

    fun close(onClosed: () -> Unit) {
        val instance = ProcessCameraProvider.getInstance(activity)
        val executor = ContextCompat.getMainExecutor(activity)
        instance.addListener({
            val provider = instance.get()
            provider.unbind(preview, analysis)
            opened = false
            onClosed()
        }, executor)
    }

    fun torch(state: Boolean) {
        camera.cameraControl.enableTorch(state)
    }

    fun zoom(ratio: Float) {
        camera.cameraControl.setZoomRatio(ratio)
    }

    fun dispose(onDisposed: () -> Unit) {
        if (opened) close {
            textureEntry.release()
            onDisposed()
        }
        else {
            textureEntry.release()
            onDisposed()
        }
    }
}