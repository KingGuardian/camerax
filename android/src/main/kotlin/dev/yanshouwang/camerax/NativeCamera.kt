package dev.yanshouwang.camerax

import androidx.camera.core.Camera
import androidx.camera.core.ImageProxy
import androidx.camera.core.UseCase
import io.flutter.view.TextureRegistry

class NativeCamera(
    value: Camera,
    val useCases: List<UseCase>,
) : NativeValue<Camera>(value) {
    lateinit var textureEntry: TextureRegistry.SurfaceTextureEntry
}