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

  CameraController({
    this.selector = CameraSelector.back,
  }) : super(null) {
    subsrcibe();
  }

  void subsrcibe() {
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
            event.uuid == value?.uuid)
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
            event.uuid == value?.uuid)
        .map((event) => event.zoomValue)
        .listen((zoomValue) {
      value = value!.copyWith(
        zoomValue: value!.zoomValue.copyWith(
          value: zoomValue,
        ),
      );
    });
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
      selector: selector,
    ).toProtobuf();
    value = await methodChannel
        .invokeMethod<Uint8List>('', openArguments)
        .then((protobuf) => CameraValue.fromProtobuf(protobuf!));
  }

  Future<void> close() async {
    _throwAfterDisposed('close');
    final methodArguments = MethodArguments(
      uuid: value!.uuid,
      category: MethodCategory.cameraControllerClose,
    ).toProtobuf();
    await methodChannel.invokeMethod<void>('', methodArguments);
    value = null;
  }

  Future<void> torch(bool state) async {
    _throwAfterDisposed('torch');
    final methodArguments = MethodArguments(
      uuid: value!.uuid,
      category: MethodCategory.cameraControllerTorch,
      torchState: state,
    ).toProtobuf();
    await methodChannel.invokeMethod<void>('', methodArguments);
  }

  Future<void> zoom(double value) async {
    _throwAfterDisposed('zoom');
    final command = MethodArguments(
      uuid: this.value!.uuid,
      category: MethodCategory.cameraControllerZoom,
      zoomValue: value,
    ).toProtobuf();
    await methodChannel.invokeMethod<void>('', command);
  }

  bool _disposed = false;
  @override
  void dispose() async {
    _throwAfterDisposed('dispose');
    // 关闭相机
    if (value != null) await close();
    // 停止监听焦距
    await _zoomValueStreamSubscription.cancel();
    // 停止监听闪光灯状态
    await _torchStateStreamSubscription.cancel();
    // 停止监听屏幕旋转
    await _quarterTurnsStreamSubscription.cancel();
    super.dispose();
    _disposed = true;
  }

  void _throwAfterDisposed(String functionName) {
    if (_disposed) {
      throw Exception('$functionName was called on a disposed $runtimeType.');
    }
  }
}
