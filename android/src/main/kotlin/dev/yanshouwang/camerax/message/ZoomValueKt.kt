//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: messages.proto

package dev.yanshouwang.camerax.message;

@kotlin.jvm.JvmSynthetic
inline fun zoomValue(block: dev.yanshouwang.camerax.message.ZoomValueKt.Dsl.() -> Unit): dev.yanshouwang.camerax.message.Messages.ZoomValue =
  dev.yanshouwang.camerax.message.ZoomValueKt.Dsl._create(dev.yanshouwang.camerax.message.Messages.ZoomValue.newBuilder()).apply { block() }._build()
object ZoomValueKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  class Dsl private constructor(
    @kotlin.jvm.JvmField private val _builder: dev.yanshouwang.camerax.message.Messages.ZoomValue.Builder
  ) {
    companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: dev.yanshouwang.camerax.message.Messages.ZoomValue.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): dev.yanshouwang.camerax.message.Messages.ZoomValue = _builder.build()

    /**
     * <code>double minimum = 1;</code>
     */
    var minimum: kotlin.Double
      @JvmName("getMinimum")
      get() = _builder.getMinimum()
      @JvmName("setMinimum")
      set(value) {
        _builder.setMinimum(value)
      }
    /**
     * <code>double minimum = 1;</code>
     */
    fun clearMinimum() {
      _builder.clearMinimum()
    }

    /**
     * <code>double maximum = 2;</code>
     */
    var maximum: kotlin.Double
      @JvmName("getMaximum")
      get() = _builder.getMaximum()
      @JvmName("setMaximum")
      set(value) {
        _builder.setMaximum(value)
      }
    /**
     * <code>double maximum = 2;</code>
     */
    fun clearMaximum() {
      _builder.clearMaximum()
    }

    /**
     * <code>double value = 3;</code>
     */
    var value: kotlin.Double
      @JvmName("getValue")
      get() = _builder.getValue()
      @JvmName("setValue")
      set(value) {
        _builder.setValue(value)
      }
    /**
     * <code>double value = 3;</code>
     */
    fun clearValue() {
      _builder.clearValue()
    }
  }
}
@kotlin.jvm.JvmSynthetic
inline fun dev.yanshouwang.camerax.message.Messages.ZoomValue.copy(block: dev.yanshouwang.camerax.message.ZoomValueKt.Dsl.() -> Unit): dev.yanshouwang.camerax.message.Messages.ZoomValue =
  dev.yanshouwang.camerax.message.ZoomValueKt.Dsl._create(this.toBuilder()).apply { block() }._build()
