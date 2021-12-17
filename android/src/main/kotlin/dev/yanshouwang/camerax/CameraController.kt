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

    fun focusAutomatically() {
        camera.cameraControl.cancelFocusAndMetering()
    }

    fun focusManually(width: Float, height: Float, x: Float, y: Float) {
        // 转到相机方向需要的角度（逆时针）
        val rotationDegrees =
            (cameraInfo.sensorRotationDegrees - activity.rotationDegrees + 360) % 360
        val point =
            when (rotationDegrees) {
                0 -> {
                    SurfaceOrientedMeteringPointFactory(width, height)
                        .createPoint(x, y)
                }
                90 -> {
                    SurfaceOrientedMeteringPointFactory(height, width)
                        .createPoint(y, width - x)
                }
                180 -> {
                    SurfaceOrientedMeteringPointFactory(width, height)
                        .createPoint(width - x, height - y)
                }
                270 -> {
                    SurfaceOrientedMeteringPointFactory(height, width)
                        .createPoint(height - y, x)
                }
                else -> {
                    throw NotImplementedError()
                }
            }
        val action = FocusMeteringAction.Builder(point, FocusMeteringAction.FLAG_AF)
            .disableAutoCancel()
            .build()
        camera.cameraControl.startFocusAndMetering(action)
    }

    fun dispose() {
        textureEntry.release()
    }
}