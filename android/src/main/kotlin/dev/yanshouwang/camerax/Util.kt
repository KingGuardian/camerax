package dev.yanshouwang.camerax

import android.app.Activity
import android.os.Build
import android.view.Surface
import androidx.camera.core.Camera
import dev.yanshouwang.camerax.communication.Communication
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.IllegalArgumentException

val Any.TAG: String
    get() = this::class.java.simpleName

val MethodCall.message: Communication.Message
    get() {
        val data = arguments<ByteArray>()
        return Communication.Message.parseFrom(data)
    }

fun MethodChannel.Result.success() = success(null)

fun MethodChannel.Result.error(e: Exception) {
    val errorCode = e.localizedMessage ?: e.stackTraceToString()
    error(errorCode)
}

fun MethodChannel.Result.error(errorCode: String) {
    val errorMessage: String? = null
    val errorDetails: String? = null
    error(errorCode, errorMessage, errorDetails)
}

val Activity.quarterTurns: Int
    get() {
        @Suppress("DEPRECATION")
        val rotation = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) display!!.rotation
        else windowManager.defaultDisplay.rotation
        return when (rotation) {
            Surface.ROTATION_0 -> 0
            Surface.ROTATION_90 -> 3
            Surface.ROTATION_180 -> 2
            Surface.ROTATION_270 -> 1
            else -> throw IllegalArgumentException()
        }
    }