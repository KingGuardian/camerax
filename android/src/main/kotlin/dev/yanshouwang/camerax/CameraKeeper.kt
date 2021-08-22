package dev.yanshouwang.camerax

import androidx.camera.core.Camera
import androidx.camera.core.UseCase
import io.flutter.view.TextureRegistry

data class CameraKeeper(
    val camera: Camera,
    val useCases: List<UseCase>,
    val textureEntry: TextureRegistry.SurfaceTextureEntry
)