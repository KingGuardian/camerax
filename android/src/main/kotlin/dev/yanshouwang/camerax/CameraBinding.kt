package dev.yanshouwang.camerax

import android.util.Size
import androidx.camera.core.Camera
import androidx.camera.core.UseCase
import io.flutter.view.TextureRegistry

data class CameraBinding(
    val camera: Camera,
    val useCases: List<UseCase>,
    val textureEntry: TextureRegistry.SurfaceTextureEntry,
    val size: Size
)