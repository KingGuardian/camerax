import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'focus_mode.dart';
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
  // Here we use a completer to call methods after created.
  final Completer<void> created;
  @override
  final ValueNotifier<$CameraValue?> valueListenable;

  late StreamSubscription<int> quarterTurnsSubscription;
  late StreamSubscription<bool> torchStateSubscription;
  late StreamSubscription<double> zoomValueSubscription;

  String? uuid;

  $CameraController(this.selector)
      : created = Completer(),
        valueListenable = ValueNotifier(null) {
    subsrcibe();
    create();
  }

  void subsrcibe() async {
    // 监听屏幕旋转
    quarterTurnsSubscription = event
        .where((event) =>
            event.category ==
            messages.EventCategory.EVENT_CATEGORY_QUARTER_TURNS)
        .map((event) => event.quarterTurns)
        .listen((quarterTurns) {
      valueListenable.value = valueListenable.value?.copyWith(
        textureValue: valueListenable.value!.textureValue.copyWith(
          quarterTurns: quarterTurns,
        ),
      );
    });
    // 监听闪光灯状态
    torchStateSubscription = event
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE &&
            event.uuid == uuid)
        .map((event) => event.torchState)
        .listen((trochState) {
      valueListenable.value = valueListenable.value?.copyWith(
        torchValue: valueListenable.value!.torchValue.copyWith(
          state: trochState,
        ),
      );
    });
    // 监听相机焦距
    zoomValueSubscription = event
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE &&
            event.uuid == uuid)
        .map((event) => event.zoomValue)
        .listen((zoomValue) {
      valueListenable.value = valueListenable.value?.copyWith(
        zoomValue: valueListenable.value!.zoomValue.copyWith(
          value: zoomValue,
        ),
      );
    });
  }

  void unsubsrcibe() async {
    // 停止监听焦距
    await zoomValueSubscription.cancel();
    // 停止监听闪光灯状态
    await torchStateSubscription.cancel();
    // 停止监听屏幕旋转
    await quarterTurnsSubscription.cancel();
  }

  void create() async {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_CREATE,
      selector: selector.toMessage(),
    );
    try {
      uuid = await methodChannel
          .invokeCommand<String>(command)
          .then((uuid) => uuid!);
      created.complete();
    } catch (e) {
      created.completeError(e);
    }
  }

  @override
  Stream<ImageProxy> get imageProxy {
    return event
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY &&
            event.uuid == uuid)
        .map((event) => $ImageProxy.fromMessage(event.imageProxy));
  }

  @override
  Future<void> open() async {
    await created.future;
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN,
      uuid: uuid,
    );
    valueListenable.value = await methodChannel
        .invokeCommand<Uint8List>(command)
        .then((protoBuffer) => $CameraValue.fromProtobuf(protoBuffer!));
  }

  @override
  Future<void> close() async {
    await created.future;
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE,
      uuid: uuid,
    );
    await methodChannel.invokeCommand<void>(command);
    valueListenable.value = null;
  }

  @override
  Future<void> torch(bool state) async {
    await created.future;
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH,
      uuid: uuid,
      torchState: state,
    );
    await methodChannel.invokeCommand<void>(command);
  }

  @override
  Future<void> zoom(double value) async {
    await created.future;
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM,
      uuid: uuid,
      zoomValue: value,
    );
    await methodChannel.invokeCommand<void>(command);
  }

  @override
  Future<void> focusAutomatically() async {
    await created.future;
    final command = messages.Command(
      category: messages.CommandCategory
          .COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY,
      uuid: uuid,
    );
    await methodChannel.invokeCommand<void>(command);
    valueListenable.value =
        valueListenable.value?.copyWith(focusMode: FocusMode.auto);
  }

  @override
  Future<void> focusManually(Size size, Offset offset) async {
    await created.future;
    final command = messages.Command(
      category: messages
          .CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY,
      uuid: uuid,
      size: size.toMessage(),
      offset: offset.toMessage(),
    );
    await methodChannel.invokeCommand<void>(command);
    valueListenable.value =
        valueListenable.value?.copyWith(focusMode: FocusMode.manual);
  }

  @override
  void dispose() async {
    try {
      await created.future;
      final command = messages.Command(
        category:
            messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_DISPOSE,
      );
      await methodChannel.invokeCommand<void>(command);
    } finally {
      unsubsrcibe();
      valueListenable.dispose();
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
  @override
  final FocusMode focusMode;

  const $CameraValue({
    required this.textureValue,
    required this.torchValue,
    required this.zoomValue,
    this.focusMode = FocusMode.auto,
  });

  factory $CameraValue.fromProtobuf(Uint8List protoBuffer) {
    final cameraValue = messages.CameraValue.fromBuffer(protoBuffer);
    final textureValue = $TextureValue.fromMessage(cameraValue.textureValue);
    final torchValue = $TorchValue.fromMessage(cameraValue.torchValue);
    final zoomValue = $ZoomValue.fromMessage(cameraValue.zoomValue);
    return $CameraValue(
      textureValue: textureValue,
      torchValue: torchValue,
      zoomValue: zoomValue,
    );
  }

  $CameraValue copyWith({
    $TextureValue? textureValue,
    $TorchValue? torchValue,
    $ZoomValue? zoomValue,
    FocusMode? focusMode,
  }) {
    textureValue ??= this.textureValue;
    torchValue ??= this.torchValue;
    zoomValue ??= this.zoomValue;
    focusMode ??= this.focusMode;
    return $CameraValue(
      textureValue: textureValue,
      torchValue: torchValue,
      zoomValue: zoomValue,
      focusMode: focusMode,
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
    final command = messages.Command(
      category: messages.CommandCategory.COMMAND_CATEGORY_IMAGE_PROXY_CLOSE,
      uuid: uuid,
    );
    await methodChannel.invokeCommand<void>(command);
  }
}

extension on CameraSelector {
  messages.CameraSelector toMessage() {
    final facing = messages.CameraFacing.values[this.facing.index];
    return messages.CameraSelector(facing: facing);
  }
}

extension on Size {
  messages.Size toMessage() {
    return messages.Size(width: width, height: height);
  }
}

extension on Offset {
  messages.Offset toMessage() {
    return messages.Offset(x: dx, y: dy);
  }
}
