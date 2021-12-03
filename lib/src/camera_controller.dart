import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'camera_selector.dart';
import 'camera_value.dart';
import 'channels.dart';
import 'event_category.dart';
import 'image_proxy.dart';
import 'method_arguments.dart';
import 'method_category.dart';

class CameraController extends ValueNotifier<CameraValue?> {
  final CameraSelector selector;

  late StreamSubscription<int> _quarterTurnsStreamSubscription;
  late StreamSubscription<bool> _torchStateStreamSubscription;
  late StreamSubscription<double> _zoomValueStreamSubscription;
  late String _uuid;

  CameraController({
    this.selector = CameraSelector.back,
  }) : super(null) {
    _create();
    _subsrcibe();
  }

  void _create() async {
    final createArguments = MethodArguments(
      category: MethodCategory.cameraControllerCreate,
      selector: selector,
    );
    _uuid = await methodChannel
        .invokeByMethodArguments<String>(createArguments)
        .then((uuid) => uuid!);
  }

  void _subsrcibe() {
    // 监听屏幕旋转
    _quarterTurnsStreamSubscription = eventStream
        .where((event) => event.category == EventCategory.quarterTurns)
        .map((event) => event.quarterTurns)
        .listen((quarterTurns) {
      value = value?.copyWith(
        textureValue: value!.textureValue.copyWith(
          quarterTurns: quarterTurns,
        ),
      );
    });
    // 监听闪光灯状态
    _torchStateStreamSubscription = eventStream
        .where((event) =>
            event.category == EventCategory.cameraControllerTorchState &&
            event.uuid == _uuid)
        .map((event) => event.torchState)
        .listen((trochState) {
      value = value!.copyWith(
        torchValue: value!.torchValue.copyWith(
          state: trochState,
        ),
      );
    });
    // 监听相机焦距
    _zoomValueStreamSubscription = eventStream
        .where((event) =>
            event.category == EventCategory.cameraControllerZoomValue &&
            event.uuid == _uuid)
        .map((event) => event.zoomValue)
        .listen((zoomValue) {
      value = value!.copyWith(
        zoomValue: value!.zoomValue.copyWith(
          value: zoomValue,
        ),
      );
    });
  }

  void _unsubsrcibe() async {
    // 停止监听焦距
    await _zoomValueStreamSubscription.cancel();
    // 停止监听闪光灯状态
    await _torchStateStreamSubscription.cancel();
    // 停止监听屏幕旋转
    await _quarterTurnsStreamSubscription.cancel();
  }

  Stream<ImageProxy> get imageStream {
    return eventStream
        .where((event) =>
            event.category == EventCategory.cameraControllerImageProxy)
        .map((event) => event.imageProxy);
  }

  Future<void> open() async {
    _throwAfterDisposed('open');
    final openArguments = MethodArguments(
      category: MethodCategory.cameraControllerOpen,
      uuid: _uuid,
    );
    value = await methodChannel
        .invokeByMethodArguments<Uint8List>(openArguments)
        .then((protoBuffer) => CameraValue.fromProtobuf(protoBuffer!));
  }

  Future<void> close() async {
    _throwAfterDisposed('close');
    final closeArguments = MethodArguments(
      uuid: _uuid,
      category: MethodCategory.cameraControllerClose,
    );
    await methodChannel.invokeByMethodArguments<void>(closeArguments);
    value = null;
  }

  Future<void> torch(bool state) async {
    _throwAfterDisposed('torch');
    final torchArguments = MethodArguments(
      uuid: _uuid,
      category: MethodCategory.cameraControllerTorch,
      torchState: state,
    );
    await methodChannel.invokeByMethodArguments<void>(torchArguments);
  }

  Future<void> zoom(double value) async {
    _throwAfterDisposed('zoom');
    final zoomArguments = MethodArguments(
      uuid: _uuid,
      category: MethodCategory.cameraControllerZoom,
      zoomValue: value,
    );
    await methodChannel.invokeByMethodArguments<void>(zoomArguments);
  }

  bool _disposed = false;
  @override
  void dispose() async {
    _throwAfterDisposed('dispose');
    // 关闭相机
    final disposeArguments = MethodArguments(
      uuid: _uuid,
      category: MethodCategory.cameraControllerDispose,
    );
    await methodChannel.invokeByMethodArguments<void>(disposeArguments);
    _unsubsrcibe();
    super.dispose();
    _disposed = true;
  }

  void _throwAfterDisposed(String functionName) {
    if (_disposed) {
      throw Exception('$functionName was called on a disposed $runtimeType.');
    }
  }
}
