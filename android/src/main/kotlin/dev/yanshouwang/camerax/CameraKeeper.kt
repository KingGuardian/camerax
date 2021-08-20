package dev.yanshouwang.camerax

import androidx.camera.core.Camera
import androidx.camera.core.UseCase

data class CameraKeeper(val camera: Camera, val useCases: Array<UseCase>)