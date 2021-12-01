package dev.yanshouwang.camerax

import android.app.Activity
import android.graphics.ImageFormat
import android.os.Build
import android.view.Surface
import androidx.annotation.IntDef
import androidx.camera.core.ImageProxy
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.IllegalArgumentException
import java.nio.ByteBuffer

val Any.TAG: String
    get() = this::class.java.simpleName

val MethodCall.methodArguments: Messages.MethodArguments
    get() {
        val data = arguments<ByteArray>()
        return Messages.MethodArguments.parseFrom(data)
    }

fun Result.success() = success(null)

fun Result.error(e: Exception) {
    val errorCode = e.localizedMessage ?: e.stackTrace.toString()
    error(errorCode)
}

fun Result.error(errorCode: String) {
    error(errorCode, null, null)
}

@IntDef(value = [Surface.ROTATION_0, Surface.ROTATION_90, Surface.ROTATION_180, Surface.ROTATION_270])
@kotlin.annotation.Retention(AnnotationRetention.SOURCE)
annotation class Rotation


@Suppress("DEPRECATION")
@Rotation
val Activity.rotation: Int
    get() = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) display!!.rotation
    else windowManager.defaultDisplay.rotation

val Activity.quarterTurns: Int
    get() {
        return when (rotation) {
            Surface.ROTATION_0 -> 0
            Surface.ROTATION_90 -> 3
            Surface.ROTATION_180 -> 2
            Surface.ROTATION_270 -> 1
            else -> throw IllegalArgumentException()
        }
    }

val ImageProxy.bytes: ByteArray
    get() {
        val crop = this.cropRect
        val cropWidth = crop.width()
        val cropHeight = crop.height()
        val pixelSize = cropWidth * cropHeight
        val bitsPerPixel = ImageFormat.getBitsPerPixel(ImageFormat.YUV_420_888)
        val byteBuffer = ByteBuffer.allocateDirect(pixelSize * bitsPerPixel / 8)
        byteBuffer.rewind()
        val bytes = byteBuffer.array()
        planes.forEachIndexed { index, plane ->
            val width: Int
            val height: Int
            // How many values are read in input for each output value written
            // Only the Y plane has a value for every pixel, U and V have half the resolution i.e.
            //
            // Y Plane            U Plane    V Plane
            // ===============    =======    =======
            // Y Y Y Y Y Y Y Y    U U U U    V V V V
            // Y Y Y Y Y Y Y Y    U U U U    V V V V
            // Y Y Y Y Y Y Y Y    U U U U    V V V V
            // Y Y Y Y Y Y Y Y    U U U U    V V V V
            // Y Y Y Y Y Y Y Y
            // Y Y Y Y Y Y Y Y
            // Y Y Y Y Y Y Y Y
            val stride: Int
            // The index in the output buffer the next value will be written at
            // For Y it's zero, for U and V we start at the end of Y and interleave them i.e.
            //
            // First chunk        Second chunk
            // ===============    ===============
            // Y Y Y Y Y Y Y Y    V U V U V U V U
            // Y Y Y Y Y Y Y Y    V U V U V U V U
            // Y Y Y Y Y Y Y Y    V U V U V U V U
            // Y Y Y Y Y Y Y Y    V U V U V U V U
            // Y Y Y Y Y Y Y Y
            // Y Y Y Y Y Y Y Y
            // Y Y Y Y Y Y Y Y
            var offset: Int
            when (index) {
                0 -> {
                    width = cropWidth
                    height = cropHeight
                    stride = 1
                    offset = 0
                }
                1 -> {
                    width = cropWidth / 2
                    height = cropHeight / 2
                    stride = 2
                    // For NV21 format, U is in odd-numbered indices
                    offset = pixelSize + 1
                }
                2 -> {
                    width = cropWidth / 2
                    height = cropHeight / 2
                    stride = 2
                    // For NV21 format, V is in even-numbered indices
                    offset = pixelSize
                }
                else -> return@forEachIndexed
            }
            val buffer = plane.buffer
            val rowStride = plane.rowStride
            val pixelStride = plane.pixelStride
            // Intermediate buffer used to store the bytes of each row
            val rawBytes = ByteArray(plane.rowStride)
            // Size of each row in bytes
            val rowLength =
                    if (pixelStride == 1 && stride == 1) width
                    // Take into account that the stride may include data from pixels other than this
                    // particular plane and row, and that could be between pixels and not after every
                    // pixel:
                    //
                    // |---- Pixel stride ----|                    Row ends here --> |
                    // | Pixel 1 | Other Data | Pixel 2 | Other Data | ... | Pixel N |
                    //
                    // We need to get (N-1) * (pixel stride bytes) per row + 1 byte for the last pixel
                    else (width - 1) * pixelStride + 1
            for (row in 0 until height) {
                // Move buffer position to the beginning of this row
                val newPosition = (row + crop.top) * rowStride + crop.left * pixelStride
                buffer.position(newPosition)
                if (pixelStride == 1 && stride == 1) {
                    // When there is a single stride value for pixel and output, we can just copy
                    // the entire row in a single step
                    buffer.get(bytes, offset, rowLength)
                    offset += rowLength
                } else {
                    // When either pixel or output have a stride > 1 we must copy pixel by pixel
                    buffer.get(rawBytes, 0, rowLength)
                    for (column in 0 until width) {
                        bytes[offset] = rawBytes[column * pixelStride]
                        offset += stride
                    }
                }
            }
        }
        return bytes
    }

fun rotate90(nv21: ByteArray, width: Int, height: Int): ByteArray {
    val yuv = ByteArray(width * height * 3 / 2)
    // 旋转 Y 亮度分量
    var i = 0
    for (x in 0 until width) {
        for (y in height - 1 downTo 0) {
            yuv[i] = nv21[y * width + x]
            i++
        }
    }
    // 旋转 U, V 色度分量
    i = width * height * 3 / 2 - 1
    var x = width - 1
    while (x > 0) {
        for (y in 0 until height / 2) {
            yuv[i] = nv21[width * height + y * width + x]
            i--
            yuv[i] = nv21[width * height + y * width + (x - 1)]
            i--
        }
        x -= 2
    }
    return yuv
}

fun rotate180(nv21: ByteArray, width: Int, height: Int): ByteArray {
    val yuv = ByteArray(width * height * 3 / 2)
    // 旋转 Y 亮度分量
    var count = 0
    var i = width * height - 1
    while (i >= 0) {
        yuv[count] = nv21[i]
        count++
        i--
    }
    // 旋转 U, V 色度分量
    i = width * height * 3 / 2 - 1
    while (i >= width * height) {
        yuv[count++] = nv21[i - 1]
        yuv[count++] = nv21[i]
        i -= 2
    }
    return yuv
}

fun rotate270(nv21: ByteArray, width: Int, height: Int): ByteArray {
    val yuv = ByteArray(width * height * 3 / 2)
    // 旋转 Y 亮度分量
    var i = 0
    for (x in width - 1 downTo 0) {
        for (y in 0 until width) {
            yuv[i] = nv21[y * width + x]
            i++
        }
    }
    // 旋转 U, V 色度分量
    i = width * height
    var x = width - 1
    while (x > 0) {
        for (y in 0 until height / 2) {
            yuv[i] = nv21[width * height + y * width + (x - 1)]
            i++
            yuv[i] = nv21[width * height + y * width + x]
            i++
        }
        x -= 2
    }
    return yuv
}