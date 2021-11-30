import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'camera_facing.dart';
import 'camera_selector.dart';
import 'camera_value.dart';
import 'channels.dart';
import 'messages.dart' as messages;

abstract class Controller extends ValueNotifier<CameraValue?> {
  Controller() : super(null);

  CameraSelector get selector;
  Stream<ImageProxy> get images;

  Future<void> open();
  Future<void> close();
  Future<void> torch(bool state);
  Future<void> zoom(double value);
}

class CameraController extends ValueNotifier<CameraValue?> {
  final CameraSelector selector;

  late StreamSubscription<int> _quarterTurnsSubscription;
  late StreamSubscription<bool> _torchStateSubscription;
  late StreamSubscription<double> _zoomValueSubscription;

  bool _disposed = false;
  FutureOr<bool>? _opened;

  CameraController({
    this.selector = CameraSelector.back,
  }) : super(null);

  Stream<ImageProxy> get images {
    _throwWhenDisposed('images');
    return stream
        .where((event) =>
            event.key == value?._key &&
            event.category == messages.EventCategory.IMAGE_PROXY_RECEIVED)
        .map((event) => event.image.mirror);
  }

  Future<void> open() async {
    _throwWhenDisposed('open');
    _opened = true;
    final command = messages.Command(
      category: messages.CommandCategory.OPEN,
      openArguments: messages.OpenArguments(
        selector: selector.message,
      ),
    ).writeToBuffer();
    value = await method.invokeMethod<Uint8List>('', command).then(
        (byteArray) => messages.CameraValue.fromBuffer(byteArray!).mirror);
    // 开始状态监听
    _quarterTurnsSubscription = stream
        .where((event) =>
            event.category == messages.EventCategory.QUARTER_TURNS_CHANGED)
        .map((event) => event.quarterTurns)
        .listen((quarterTurns) {
      final textureValue =
          value!.textureValue._copyWith(quarterTurns: quarterTurns);
      value = value!._copyWith(textureValue: textureValue);
    });
    _torchStateSubscription = stream
        .where((event) =>
            event.key == value?._key &&
            event.category == messages.EventCategory.TORCH_STATE_CHANGED)
        .map((event) => event.torchState)
        .listen((state) {
      final torchValue = value!.torchValue._copyWith(state: state);
      value = value!._copyWith(torchValue: torchValue);
    });
    _zoomValueSubscription = stream
        .where((event) =>
            event.key == value?._key &&
            event.category == messages.EventCategory.ZOOM_VALUE_CHANGED)
        .map((event) => event.zoomValue)
        .listen((value) {
      final zoomValue = this.value!.zoomValue._copyWith(value: value);
      this.value = this.value!._copyWith(zoomValue: zoomValue);
    });
  }

  Future<void> close() async {
    _throwWhenDisposedOrClosed('close');
    _opened = null;
    // 停止状态监听
    await _zoomValueSubscription.cancel();
    await _torchStateSubscription.cancel();
    await _quarterTurnsSubscription.cancel();
    final command = messages.Command(
      key: value!._key,
      category: messages.CommandCategory.CLOSE,
    ).writeToBuffer();
    await method.invokeMethod<void>('', command);
    value = null;
  }

  Future<void> torch(bool state) async {
    _throwWhenDisposedOrClosed('torch');
    final command = messages.Command(
      key: value!._key,
      category: messages.CommandCategory.TORCH,
      torchState: state,
    ).writeToBuffer();
    await method.invokeMethod<void>('', command);
  }

  Future<void> zoom(double value) async {
    _throwWhenDisposedOrClosed('zoom');
    final command = messages.Command(
      key: this.value!._key,
      category: messages.CommandCategory.ZOOM,
      zoomValue: value,
    ).writeToBuffer();
    await method.invokeMethod<void>('', command);
  }

  @override
  void dispose() async {
    _throwWhenDisposed('dispose');
    _disposed = true;
    if (_opened != null) {
      await _opened;
      await close();
    }
    super.dispose();
  }

  void _throwWhenDisposedOrClosed(String name) {
    _throwWhenDisposed(name);
    if (value == null) {
      throw Exception('$name was called on a closed CameraController.');
    }
  }

  void _throwWhenDisposed(String name) {
    if (_disposed) {
      throw Exception('$name was called on a disposed CameraController.');
    }
  }
}

class TextureValue {
  final int id;
  final int width;
  final int height;
  final int quarterTurns;

  TextureValue._(
    this.id,
    this.width,
    this.height,
    this.quarterTurns,
  );

  TextureValue _copyWith({int? quarterTurns}) {
    quarterTurns ??= this.quarterTurns;
    return TextureValue._(
      id,
      width,
      height,
      quarterTurns,
    );
  }
}

class TorchValue {
  final bool available;
  final bool state;

  TorchValue._(this.available, this.state);

  TorchValue _copyWith({bool? state}) {
    state ??= this.state;
    return TorchValue._(available, state);
  }
}

class ZoomValue {
  double minimum;
  double maximum;
  double value;

  ZoomValue._(this.minimum, this.maximum, this.value);

  ZoomValue _copyWith({double? value}) {
    value ??= this.value;
    return ZoomValue._(minimum, maximum, value);
  }
}

class ImageProxy {
  final String _key;
  final Uint8List data;
  final int width;
  final int height;

  ImageProxy._(this._key, this.data, this.width, this.height);

  Future<void> close() async {
    final command = messages.Command(
      key: _key,
      category: messages.CommandCategory.CLOSE_IMAGE_PROXY,
    ).writeToBuffer();
    await method.invokeMethod<void>('', command);
  }
}

extension on CameraSelector {
  messages.CameraSelector get message =>
      messages.CameraSelector(facing: facing.message);
}

extension on CameraFacing {
  messages.CameraFacing get message {
    switch (this) {
      case CameraFacing.back:
        return messages.CameraFacing.BACK;
      case CameraFacing.front:
        return messages.CameraFacing.FRONT;
    }
  }
}

extension on messages.CameraValue {
  CameraValue get mirror => CameraValue._(
        key,
        textureValue.mirror,
        torchValue.mirror,
        zoomValue.mirror,
      );
}

extension on messages.TextureValue {
  TextureValue get mirror => TextureValue._(id, width, height, quarterTurns);
}

extension on messages.TorchValue {
  TorchValue get mirror => TorchValue._(available, state);
}

extension on messages.ZoomValue {
  ZoomValue get mirror => ZoomValue._(minimum, maximum, value);
}

extension on messages.ImageProxy {
  ImageProxy get mirror {
    final data = Uint8List.fromList(this.data);
    return ImageProxy._(key, data, width, height);
  }
}
