package dev.yanshouwang.camerax

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.graphics.ImageFormat
import android.graphics.Rect
import android.os.Build
import android.util.Log
import android.view.Surface
import androidx.annotation.NonNull
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.protobuf.ByteString
import dev.yanshouwang.camerax.messages.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.*
import io.flutter.view.TextureRegistry
import java.nio.ByteBuffer
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.TimeoutException

/** CameraXPlugin */
class CameraXPlugin() : FlutterPlugin, ActivityAware {
    companion object {
        private const val NAMESPACE = "yanshouwang.dev/camerax"
        const val REQUEST_CODE = 3543
    }

    private var cameraXMethodHandler: CameraXMethodHandler? = null
    private var flutterPluginBinding: FlutterPluginBinding? = null
    override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
        flutterPluginBinding = binding
    }
    override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {
        flutterPluginBinding = null
    }
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        if (flutterPluginBinding != null) {
            startListen(binding, flutterPluginBinding!!.binaryMessenger, flutterPluginBinding!!.textureRegistry)
        }
    }

    override fun onDetachedFromActivity() {
        cameraXMethodHandler?.stopListen()
        cameraXMethodHandler = null
    }
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }
    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
    private fun startListen(binding: ActivityPluginBinding, messenger: BinaryMessenger, textureRegistry: TextureRegistry) {
        cameraXMethodHandler = CameraXMethodHandler(binding, messenger, textureRegistry)
        cameraXMethodHandler?.startListen()
    }
}

val Any.TAG: String
    get() = this::class.java.simpleName

val MethodCall.command: Messages.Command
    get() {
        val data = arguments<ByteArray>()
        return Messages.Command.parseFrom(data)
    }

fun MethodChannel.Result.success() = success(null)

fun MethodChannel.Result.error(errorCode: String, errorMessage: String) {
    error(errorCode, errorMessage, null)
}

fun MethodChannel.Result.error(e: Exception) {
    val errorCode = e.TAG
    val errorMessage = e.localizedMessage
    val errorDetails = e.stackTraceToString()
    error(errorCode, errorMessage, errorDetails)
}

fun EventChannel.EventSink.error(errorCode: String, errorMessage: String) {
    error(errorCode, errorMessage, null)
}

@Suppress("DEPRECATION")
val Activity.rotation: Int
    get() = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) display!!.rotation
    else windowManager.defaultDisplay.rotation

val Activity.rotationDegrees: Int
    get() {
        return when (rotation) {
            Surface.ROTATION_0 -> 0
            Surface.ROTATION_90 -> 90
            Surface.ROTATION_180 -> 180
            Surface.ROTATION_270 -> 270
            else -> throw IllegalArgumentException()
        }
    }

val Messages.CameraSelector.cameraxSelector: CameraSelector
    get() {
        return when (facing!!) {
            Messages.CameraFacing.CAMERA_FACING_BACK -> CameraSelector.DEFAULT_BACK_CAMERA
            Messages.CameraFacing.CAMERA_FACING_FRONT -> CameraSelector.DEFAULT_FRONT_CAMERA
            Messages.CameraFacing.UNRECOGNIZED -> throw NotImplementedError()
        }
    }
