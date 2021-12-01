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

  late StreamSubscription<int> _quarterTurnsSubscription;
  late StreamSubscription<bool> _torchStateSubscription;
  late StreamSubscription<double> _zoomValueSubscription;

  bool _disposed = false;
  FutureOr<bool>? _opened;

  CameraController({
    this.selector = CameraSelector.back,
  }) : super(null);

  Stream<ImageProxy> get imagePorxy {
    return stream
        .where((event) =>
            event.category == EventCategory.cameraControllerImageProxy)
        .map((event) => event.imageProxy);
  }

  Future<void> open() async {
    _opened = true;
    final methodArguments = MethodArguments(
      category: MethodCategory.cameraControllerOpen,
      selector: selector,
    ).toProtobuf();
    value = await method
        .invokeMethod<Uint8List>('', methodArguments)
        .then((protobuf) => CameraValue.fromProtobuf(protobuf!));
    // 监听屏幕旋转
    _quarterTurnsSubscription = stream
        .where((event) => event.category == EventCategory.quarterTurns)
        .map((event) => event.quarterTurns)
        .listen((quarterTurns) {
      value = value!.copyWith(
        textureValue: value!.textureValue.copyWith(
          quarterTurns: quarterTurns,
        ),
      );
    });
    // 监听闪光灯状态
    _torchStateSubscription = stream
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
    _zoomValueSubscription = stream
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

  Future<void> close() async {
    _opened = null;
    // 停止监听焦距
    await _zoomValueSubscription.cancel();
    // 停止监听闪光灯状态
    await _torchStateSubscription.cancel();
    // 停止监听屏幕旋转
    await _quarterTurnsSubscription.cancel();
    final methodArguments = MethodArguments(
      uuid: value!.uuid,
      category: MethodCategory.cameraControllerClose,
    ).toProtobuf();
    await method.invokeMethod<void>('', methodArguments);
    value = null;
  }

  Future<void> torch(bool state) async {
    final methodArguments = MethodArguments(
      uuid: value!.uuid,
      category: MethodCategory.cameraControllerTorch,
      torchState: state,
    ).toProtobuf();
    await method.invokeMethod<void>('', methodArguments);
  }

  Future<void> zoom(double value) async {
    final command = MethodArguments(
      uuid: this.value!.uuid,
      category: MethodCategory.cameraControllerZoom,
      zoomValue: value,
    ).toProtobuf();
    await method.invokeMethod<void>('', command);
  }

  @override
  void dispose() async {
    _disposed = true;
    if (_opened != null) {
      await _opened;
      await close();
    }
    super.dispose();
  }
}
