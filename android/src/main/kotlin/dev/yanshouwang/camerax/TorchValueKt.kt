//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: messages.proto

package dev.yanshouwang.camerax;

@kotlin.jvm.JvmSynthetic
public inline fun torchValue(block: dev.yanshouwang.camerax.TorchValueKt.Dsl.() -> kotlin.Unit): dev.yanshouwang.camerax.Messages.TorchValue =
  dev.yanshouwang.camerax.TorchValueKt.Dsl._create(dev.yanshouwang.camerax.Messages.TorchValue.newBuilder()).apply { block() }._build()
public object TorchValueKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: dev.yanshouwang.camerax.Messages.TorchValue.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: dev.yanshouwang.camerax.Messages.TorchValue.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): dev.yanshouwang.camerax.Messages.TorchValue = _builder.build()

    /**
     * <code>bool available = 1;</code>
     */
    public var available: kotlin.Boolean
      @JvmName("getAvailable")
      get() = _builder.getAvailable()
      @JvmName("setAvailable")
      set(value) {
        _builder.setAvailable(value)
      }
    /**
     * <code>bool available = 1;</code>
     */
    public fun clearAvailable() {
      _builder.clearAvailable()
    }

    /**
     * <code>bool state = 2;</code>
     */
    public var state: kotlin.Boolean
      @JvmName("getState")
      get() = _builder.getState()
      @JvmName("setState")
      set(value) {
        _builder.setState(value)
      }
    /**
     * <code>bool state = 2;</code>
     */
    public fun clearState() {
      _builder.clearState()
    }
  }
}
@kotlin.jvm.JvmSynthetic
public inline fun dev.yanshouwang.camerax.Messages.TorchValue.copy(block: dev.yanshouwang.camerax.TorchValueKt.Dsl.() -> kotlin.Unit): dev.yanshouwang.camerax.Messages.TorchValue =
  dev.yanshouwang.camerax.TorchValueKt.Dsl._create(this.toBuilder()).apply { block() }._build()
