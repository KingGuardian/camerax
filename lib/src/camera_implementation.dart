import 'dart:async';
import 'dart:typed_data';

import 'camera_controller.dart';
import 'camera_facing.dart';
import 'camera_selector.dart';
import 'camera_value.dart';
import 'channels.dart';
import 'image_proxy.dart';
import 'messages.dart' as messages;

class $CameraController implements CameraController {
  static final controllers = <CameraSelector, $CameraController>{};

  final CameraSelector selector;

  $CameraController._(this.selector);

  factory $CameraController(CameraSelector selector) {
    return controllers.putIfAbsent(
      selector,
      () => $CameraController._(selector),
    );
  }

  @override
  Stream<ImageProxy> get imageStream {
    return eventStream
        .where((event) =>
            event.category ==
            messages
                .EventCategory.EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXIED)
        .map((event) => $ImageProxy.fromMessage(
            event.cameraControllerImageProxiedArguments.imageProxy))
        .where((imageProxy) => imageProxy.selector == selector);
  }

  @override
  Future<CameraValue> bind() {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_BIND,
      cameraControllerBindArguments:
          messages.CameraControllerBindCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
      ),
    );
    return methodChannel.execute(command).then((reply) => $CameraValue
        .fromMessage(reply!.cameraControllerBindArguments.cameraValue));
  }

  @override
  Future<void> unbind() {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_UNBIND,
      cameraControllerUnbindArguments:
          messages.CameraControllerUnbindCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
      ),
    );
    return methodChannel.execute(command);
  }

  @override
  Future<void> torch(bool state) {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH,
      cameraControllerTorchArguments:
          messages.CameraControllerTorchCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
        state: state,
      ),
    );
    return methodChannel.execute(command);
  }

  @override
  Future<void> zoom(double value) {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM,
      cameraControllerZoomArguments:
          messages.CameraControllerZoomCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
        value: value,
      ),
    );
    return methodChannel.execute(command);
  }

  @override
  Future<void> focusAutomatically() {
    final command = messages.Command(
      category: messages.CommandCategory
          .COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY,
      cameraControllerFocusAutomaticallyArguments:
          messages.CameraControllerFocusAutomaticallyCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
      ),
    );
    return methodChannel.execute(command);
  }

  @override
  Future<void> focusManually(double width, double height, double x, double y) {
    final command = messages.Command(
      category: messages
          .CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY,
      cameraControllerFocusManuallyArguments:
          messages.CameraControllerFocusManuallyCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
        width: width,
        height: height,
        x: x,
        y: y,
      ),
    );
    return methodChannel.execute(command);
  }
}

class $CameraSelector implements CameraSelector {
  @override
  final CameraFacing facing;

  const $CameraSelector(this.facing);

  factory $CameraSelector.fromMessage(messages.CameraSelector selector) {
    final facing = CameraFacing.values[selector.facing.value];
    return $CameraSelector(facing);
  }

  @override
  bool operator ==(Object other) {
    return other is $CameraSelector && other.facing == facing;
  }

  @override
  int get hashCode => facing.hashCode;
}

class $CameraValue implements CameraValue {
  @override
  final int textureId;
  @override
  final int textureWidth;
  @override
  final int textureHeight;
  @override
  final bool torchAvailable;
  @override
  final double zoomMinimum;
  @override
  final double zoomMaximum;

  const $CameraValue(
    this.textureId,
    this.textureWidth,
    this.textureHeight,
    this.torchAvailable,
    this.zoomMinimum,
    this.zoomMaximum,
  );

  factory $CameraValue.fromMessage(messages.CameraValue cameraValue) {
    final textureId = cameraValue.textureId;
    final textureWidth = cameraValue.textureWidth;
    final textureHeight = cameraValue.textureHeight;
    final torchAvailable = cameraValue.torchAvailable;
    final zoomMinimum = cameraValue.zoomMinimum;
    final zoomMaximum = cameraValue.zoomMaximum;
    return $CameraValue(
      textureId,
      textureWidth,
      textureHeight,
      torchAvailable,
      zoomMinimum,
      zoomMaximum,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is $CameraValue &&
        other.textureId == textureId &&
        other.textureWidth == textureWidth &&
        other.textureHeight == textureHeight &&
        other.torchAvailable == torchAvailable &&
        other.zoomMinimum == zoomMinimum &&
        other.zoomMaximum == zoomMaximum;
  }

  @override
  int get hashCode {
    return Object.hash(
      textureId,
      textureWidth,
      textureHeight,
      torchAvailable,
      zoomMinimum,
      zoomMaximum,
    );
  }
}

class $ImageProxy implements ImageProxy {
  final CameraSelector selector;
  final String id;
  @override
  final Uint8List data;
  @override
  final int width;
  @override
  final int height;

  const $ImageProxy(
    this.selector,
    this.id,
    this.data,
    this.width,
    this.height,
  );

  factory $ImageProxy.fromMessage(
    messages.ImageProxy imageProxy,
  ) {
    final selector = $CameraSelector.fromMessage(imageProxy.selector);
    final id = imageProxy.id;
    final data = Uint8List.fromList(imageProxy.data);
    final width = imageProxy.width;
    final height = imageProxy.height;
    return $ImageProxy(selector, id, data, width, height);
  }

  @override
  Future<void> close() {
    final command = messages.Command(
      category: messages.CommandCategory.COMMAND_CATEGORY_IMAGE_PROXY_CLOSE,
      imageProxyCloseArguments: messages.ImageProxyCloseCommandArguments(
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
        id: id,
      ),
    );
    return methodChannel.execute(command);
  }
}
