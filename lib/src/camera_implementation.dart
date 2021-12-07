import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'messages.pb.dart' as messages;

import 'camera_controller.dart';
import 'camera_facing.dart';
import 'camera_selector.dart';
import 'camera_value.dart';
import 'image_proxy.dart';
import 'texture_value.dart';
import 'torch_value.dart';
import 'util.dart';
import 'zoom_value.dart';

class $CameraController implements CameraController {
  final CameraSelector selector;
  @override
  final ValueNotifier<$CameraValue?> value;

  late StreamSubscription<int> quarterTurnsStreamSubscription;
  late StreamSubscription<bool> torchStateStreamSubscription;
  late StreamSubscription<double> zoomValueStreamSubscription;
  // Here we use a completer to call methods synchronously.
  late Completer<void> completer;
  late String uuid;

  $CameraController(this.selector) : value = ValueNotifier(null) {
    subsrcibe();
    create();
  }

  void create() async {
    final newCompleter = Completer();
    completer = newCompleter;
    try {
      final createArguments = messages.MethodArguments(
        category:
            messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_CREATE,
        selector: selector.toMessage(),
      );
      uuid = await method
          .invokeByMethodArguments<String>(createArguments)
          .then((uuid) => uuid!);
    } finally {
      newCompleter.complete();
    }
  }

  void subsrcibe() async {
    // 监听屏幕旋转
    quarterTurnsStreamSubscription = stream
        .where((event) =>
            event.category ==
            messages.EventCategory.EVENT_CATEGORY_QUARTER_TURNS)
        .map((event) => event.quarterTurns)
        .listen((quarterTurns) {
      value.value = value.value?.copyWith(
        textureValue: value.value!.textureValue.copyWith(
          quarterTurns: quarterTurns,
        ),
      );
    });
    // 监听闪光灯状态
    torchStateStreamSubscription = stream
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE &&
            event.uuid == uuid)
        .map((event) => event.torchState)
        .listen((trochState) {
      value.value = value.value!.copyWith(
        torchValue: value.value!.torchValue.copyWith(
          state: trochState,
        ),
      );
    });
    // 监听相机焦距
    zoomValueStreamSubscription = stream
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE &&
            event.uuid == uuid)
        .map((event) => event.zoomValue)
        .listen((zoomValue) {
      value.value = value.value!.copyWith(
        zoomValue: value.value!.zoomValue.copyWith(
          value: zoomValue,
        ),
      );
    });
  }

  void unsubsrcibe() async {
    // 停止监听焦距
    await zoomValueStreamSubscription.cancel();
    // 停止监听闪光灯状态
    await torchStateStreamSubscription.cancel();
    // 停止监听屏幕旋转
    await quarterTurnsStreamSubscription.cancel();
  }

  @override
  Stream<ImageProxy> get imageProxy {
    return stream
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY &&
            event.uuid == uuid)
        .map((event) => $ImageProxy.fromMessage(event.imageProxy));
  }

  @override
  Future<void> open() async {
    final oldCompleter = completer;
    final newCompleter = Completer();
    completer = newCompleter;
    await oldCompleter.future;
    try {
      final openArguments = messages.MethodArguments(
        category:
            messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_OPEN,
        uuid: uuid,
      );
      value.value = await method
          .invokeByMethodArguments<Uint8List>(openArguments)
          .then((protoBuffer) => $CameraValue.fromProtobuf(protoBuffer!));
    } finally {
      newCompleter.complete();
    }
  }

  @override
  Future<void> close() async {
    final oldCompleter = completer;
    final newCompleter = Completer();
    completer = newCompleter;
    await oldCompleter.future;
    try {
      final closeArguments = messages.MethodArguments(
        uuid: uuid,
        category:
            messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_CLOSE,
      );
      await method.invokeByMethodArguments<void>(closeArguments);
      value.value = null;
    } finally {
      newCompleter.complete();
    }
  }

  @override
  Future<void> torch(bool state) async {
    final torchArguments = messages.MethodArguments(
      uuid: uuid,
      category: messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_TORCH,
      torchState: state,
    );
    await method.invokeByMethodArguments<void>(torchArguments);
  }

  @override
  Future<void> zoom(double value) async {
    final zoomArguments = messages.MethodArguments(
      uuid: uuid,
      category: messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_ZOOM,
      zoomValue: value,
    );
    await method.invokeByMethodArguments<void>(zoomArguments);
  }

  @override
  void dispose() async {
    // Methods [create] [open] [close] and [dispose] must be called synchronously.
    final oldCompleter = completer;
    final newCompleter = Completer();
    completer = newCompleter;
    await oldCompleter.future;
    try {
      if (value.value != null) {
        // We can't call [close] here in case of a dead lock.
        final closeArguments = messages.MethodArguments(
          uuid: uuid,
          category:
              messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_CLOSE,
        );
        await method.invokeByMethodArguments<void>(closeArguments);
        value.value = null;
      }
      final disposeArguments = messages.MethodArguments(
        uuid: uuid,
        category:
            messages.MethodCategory.METHOD_CATEGORY_CAMERA_CONTROLLER_DISPOSE,
      );
      await method.invokeByMethodArguments<void>(disposeArguments);
    } finally {
      newCompleter.complete();
      unsubsrcibe();
      value.dispose();
    }
  }
}

class $CameraSelector implements CameraSelector {
  @override
  final CameraFacing facing;

  const $CameraSelector(this.facing);
}

class $CameraValue implements CameraValue {
  @override
  final $TextureValue textureValue;
  @override
  final $TorchValue torchValue;
  @override
  final $ZoomValue zoomValue;

  const $CameraValue(
    this.textureValue,
    this.torchValue,
    this.zoomValue,
  );

  factory $CameraValue.fromProtobuf(Uint8List protoBuffer) {
    final cameraValue = messages.CameraValue.fromBuffer(protoBuffer);
    final textureValue = $TextureValue.fromMessage(cameraValue.textureValue);
    final torchValue = $TorchValue.fromMessage(cameraValue.torchValue);
    final zoomValue = $ZoomValue.fromMessage(cameraValue.zoomValue);
    return $CameraValue(textureValue, torchValue, zoomValue);
  }

  $CameraValue copyWith({
    $TextureValue? textureValue,
    $TorchValue? torchValue,
    $ZoomValue? zoomValue,
  }) {
    textureValue ??= this.textureValue;
    torchValue ??= this.torchValue;
    zoomValue ??= this.zoomValue;
    return $CameraValue(
      textureValue,
      torchValue,
      zoomValue,
    );
  }
}

class $TextureValue implements TextureValue {
  @override
  final int id;
  @override
  final int width;
  @override
  final int height;
  @override
  final int quarterTurns;

  const $TextureValue(
    this.id,
    this.width,
    this.height,
    this.quarterTurns,
  );

  factory $TextureValue.fromMessage(messages.TextureValue textureValue) {
    final id = textureValue.id;
    final width = textureValue.width;
    final height = textureValue.height;
    final quarterTurns = textureValue.quarterTurns;
    return $TextureValue(id, width, height, quarterTurns);
  }

  $TextureValue copyWith({int? quarterTurns}) {
    quarterTurns ??= this.quarterTurns;
    return $TextureValue(
      id,
      width,
      height,
      quarterTurns,
    );
  }
}

class $TorchValue implements TorchValue {
  @override
  final bool available;
  @override
  final bool state;

  const $TorchValue(this.available, this.state);

  factory $TorchValue.fromMessage(messages.TorchValue torchValue) {
    final available = torchValue.available;
    final state = torchValue.state;
    return $TorchValue(available, state);
  }

  $TorchValue copyWith({bool? state}) {
    state ??= this.state;
    return $TorchValue(available, state);
  }
}

class $ZoomValue implements ZoomValue {
  @override
  final double minimum;
  @override
  final double maximum;
  @override
  final double value;

  const $ZoomValue(this.minimum, this.maximum, this.value);

  factory $ZoomValue.fromMessage(messages.ZoomValue zoomValue) {
    final minimum = zoomValue.minimum;
    final maximum = zoomValue.maximum;
    final value = zoomValue.value;
    return $ZoomValue(minimum, maximum, value);
  }

  $ZoomValue copyWith({double? value}) {
    value ??= this.value;
    return $ZoomValue(minimum, maximum, value);
  }
}

class $ImageProxy implements ImageProxy {
  final String uuid;
  @override
  final Uint8List data;
  @override
  final int width;
  @override
  final int height;

  const $ImageProxy(
    this.uuid,
    this.data,
    this.width,
    this.height,
  );

  factory $ImageProxy.fromMessage(messages.ImageProxy imageProxy) {
    final uuid = imageProxy.uuid;
    final data = Uint8List.fromList(imageProxy.data);
    final width = imageProxy.width;
    final height = imageProxy.height;
    return $ImageProxy(uuid, data, width, height);
  }

  @override
  Future<void> close() async {
    final closeArguments = messages.MethodArguments(
      category: messages.MethodCategory.METHOD_CATEGORY_IMAGE_PROXY_CLOSE,
      uuid: uuid,
    );
    await method.invokeByMethodArguments<void>(closeArguments);
  }
}

extension on CameraSelector {
  messages.CameraSelector toMessage() {
    final facing = messages.CameraFacing.values[this.facing.index];
    return messages.CameraSelector(facing: facing);
  }
}
