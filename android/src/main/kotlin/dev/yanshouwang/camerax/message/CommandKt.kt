//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: messages.proto

package dev.yanshouwang.camerax.message;

@kotlin.jvm.JvmSynthetic
inline fun command(block: dev.yanshouwang.camerax.message.CommandKt.Dsl.() -> Unit): dev.yanshouwang.camerax.message.Messages.Command =
  dev.yanshouwang.camerax.message.CommandKt.Dsl._create(dev.yanshouwang.camerax.message.Messages.Command.newBuilder()).apply { block() }._build()
object CommandKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  class Dsl private constructor(
    @kotlin.jvm.JvmField private val _builder: dev.yanshouwang.camerax.message.Messages.Command.Builder
  ) {
    companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: dev.yanshouwang.camerax.message.Messages.Command.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): dev.yanshouwang.camerax.message.Messages.Command = _builder.build()

    /**
     * <code>string key = 1;</code>
     */
    var key: kotlin.String
      @JvmName("getKey")
      get() = _builder.getKey()
      @JvmName("setKey")
      set(value) {
        _builder.setKey(value)
      }
    /**
     * <code>string key = 1;</code>
     */
    fun clearKey() {
      _builder.clearKey()
    }

    /**
     * <code>.messages.CommandCategory category = 2;</code>
     */
    var category: dev.yanshouwang.camerax.message.Messages.CommandCategory
      @JvmName("getCategory")
      get() = _builder.getCategory()
      @JvmName("setCategory")
      set(value) {
        _builder.setCategory(value)
      }
    /**
     * <code>.messages.CommandCategory category = 2;</code>
     */
    fun clearCategory() {
      _builder.clearCategory()
    }

    /**
     * <code>.messages.OpenArguments open_arguments = 3;</code>
     */
    var openArguments: dev.yanshouwang.camerax.message.Messages.OpenArguments
      @JvmName("getOpenArguments")
      get() = _builder.getOpenArguments()
      @JvmName("setOpenArguments")
      set(value) {
        _builder.setOpenArguments(value)
      }
    /**
     * <code>.messages.OpenArguments open_arguments = 3;</code>
     */
    fun clearOpenArguments() {
      _builder.clearOpenArguments()
    }
    /**
     * <code>.messages.OpenArguments open_arguments = 3;</code>
     * @return Whether the openArguments field is set.
     */
    fun hasOpenArguments(): kotlin.Boolean {
      return _builder.hasOpenArguments()
    }

    /**
     * <code>bool torch_state = 4;</code>
     */
    var torchState: kotlin.Boolean
      @JvmName("getTorchState")
      get() = _builder.getTorchState()
      @JvmName("setTorchState")
      set(value) {
        _builder.setTorchState(value)
      }
    /**
     * <code>bool torch_state = 4;</code>
     */
    fun clearTorchState() {
      _builder.clearTorchState()
    }
    /**
     * <code>bool torch_state = 4;</code>
     * @return Whether the torchState field is set.
     */
    fun hasTorchState(): kotlin.Boolean {
      return _builder.hasTorchState()
    }

    /**
     * <code>double zoom_value = 5;</code>
     */
    var zoomValue: kotlin.Double
      @JvmName("getZoomValue")
      get() = _builder.getZoomValue()
      @JvmName("setZoomValue")
      set(value) {
        _builder.setZoomValue(value)
      }
    /**
     * <code>double zoom_value = 5;</code>
     */
    fun clearZoomValue() {
      _builder.clearZoomValue()
    }
    /**
     * <code>double zoom_value = 5;</code>
     * @return Whether the zoomValue field is set.
     */
    fun hasZoomValue(): kotlin.Boolean {
      return _builder.hasZoomValue()
    }
    val stubCase: dev.yanshouwang.camerax.message.Messages.Command.StubCase
      @JvmName("getStubCase")
      get() = _builder.getStubCase()

    fun clearStub() {
      _builder.clearStub()
    }
  }
}
@kotlin.jvm.JvmSynthetic
inline fun dev.yanshouwang.camerax.message.Messages.Command.copy(block: dev.yanshouwang.camerax.message.CommandKt.Dsl.() -> Unit): dev.yanshouwang.camerax.message.Messages.Command =
  dev.yanshouwang.camerax.message.CommandKt.Dsl._create(this.toBuilder()).apply { block() }._build()
