//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: communication.proto

package dev.yanshouwang.camerax.communication;

@kotlin.jvm.JvmSynthetic
inline fun cameraSelector(block: dev.yanshouwang.camerax.communication.CameraSelectorKt.Dsl.() -> Unit): dev.yanshouwang.camerax.communication.Communication.CameraSelector =
  dev.yanshouwang.camerax.communication.CameraSelectorKt.Dsl._create(dev.yanshouwang.camerax.communication.Communication.CameraSelector.newBuilder()).apply { block() }._build()
object CameraSelectorKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  class Dsl private constructor(
    @kotlin.jvm.JvmField private val _builder: dev.yanshouwang.camerax.communication.Communication.CameraSelector.Builder
  ) {
    companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: dev.yanshouwang.camerax.communication.Communication.CameraSelector.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): dev.yanshouwang.camerax.communication.Communication.CameraSelector = _builder.build()

    /**
     * <code>.communication.CameraFacing facing = 1;</code>
     */
    var facing: dev.yanshouwang.camerax.communication.Communication.CameraFacing
      @JvmName("getFacing")
      get() = _builder.getFacing()
      @JvmName("setFacing")
      set(value) {
        _builder.setFacing(value)
      }
    /**
     * <code>.communication.CameraFacing facing = 1;</code>
     */
    fun clearFacing() {
      _builder.clearFacing()
    }
  }
}
@kotlin.jvm.JvmSynthetic
inline fun dev.yanshouwang.camerax.communication.Communication.CameraSelector.copy(block: dev.yanshouwang.camerax.communication.CameraSelectorKt.Dsl.() -> Unit): dev.yanshouwang.camerax.communication.Communication.CameraSelector =
  dev.yanshouwang.camerax.communication.CameraSelectorKt.Dsl._create(this.toBuilder()).apply { block() }._build()
