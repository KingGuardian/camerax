//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: messages.proto

package dev.yanshouwang.camerax;

@kotlin.jvm.JvmSynthetic
public inline fun cameraControllerFocusAutomaticallyCommandArguments(block: dev.yanshouwang.camerax.CameraControllerFocusAutomaticallyCommandArgumentsKt.Dsl.() -> kotlin.Unit): dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments =
  dev.yanshouwang.camerax.CameraControllerFocusAutomaticallyCommandArgumentsKt.Dsl._create(dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments.newBuilder()).apply { block() }._build()
public object CameraControllerFocusAutomaticallyCommandArgumentsKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments = _builder.build()

    /**
     * <code>string id = 1;</code>
     */
    public var id: kotlin.String
      @JvmName("getId")
      get() = _builder.getId()
      @JvmName("setId")
      set(value) {
        _builder.setId(value)
      }
    /**
     * <code>string id = 1;</code>
     */
    public fun clearId() {
      _builder.clearId()
    }
  }
}
@kotlin.jvm.JvmSynthetic
public inline fun dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments.copy(block: dev.yanshouwang.camerax.CameraControllerFocusAutomaticallyCommandArgumentsKt.Dsl.() -> kotlin.Unit): dev.yanshouwang.camerax.Messages.CameraControllerFocusAutomaticallyCommandArguments =
  dev.yanshouwang.camerax.CameraControllerFocusAutomaticallyCommandArgumentsKt.Dsl._create(this.toBuilder()).apply { block() }._build()
