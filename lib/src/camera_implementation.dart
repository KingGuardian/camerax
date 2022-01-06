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
  final CameraSelector selector;

  String get id => '$hashCode';

  $CameraController(this.selector);

  @override
  Stream<ImageProxy> get imageProxied {
    return eventStream
        .where((event) =>
            event.category ==
                messages.EventCategory
                    .EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXIED &&
            event.cameraControllerImageProxiedArguments.id == id)
        .map((notification) => $ImageProxy.fromMessage(
            id, notification.cameraControllerImageProxiedArguments.imageProxy));
  }

  @override
  Future<CameraValue> bind() {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_BIND,
      cameraControllerBindArguments:
          messages.CameraControllerBindCommandArguments(
        id: id,
        selector: messages.CameraSelector(
          facing: messages.CameraFacing.values[selector.facing.index],
        ),
      ),
    );
    return methodChannel.invokeCommand(command).then((reply) => $CameraValue
        .fromMessage(reply!.cameraControllerBindArguments.cameraValue));
  }

  @override
  Future<void> unbind() {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_UNBIND,
      cameraControllerUnbindArguments:
          messages.CameraControllerUnbindCommandArguments(
        id: id,
      ),
    );
    return methodChannel.invokeCommand(command);
  }

  @override
  Future<void> torch(bool state) {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH,
      cameraControllerTorchArguments:
          messages.CameraControllerTorchCommandArguments(
        id: id,
        state: state,
      ),
    );
    return methodChannel.invokeCommand(command);
  }

  @override
  Future<void> zoom(double value) {
    final command = messages.Command(
      category:
          messages.CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM,
      cameraControllerZoomArguments:
          messages.CameraControllerZoomCommandArguments(
        id: id,
        value: value,
      ),
    );
    return methodChannel.invokeCommand(command);
  }

  @override
  Future<void> focusAutomatically() {
    final command = messages.Command(
      category: messages.CommandCategory
          .COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY,
      cameraControllerFocusAutomaticallyArguments:
          messages.CameraControllerFocusAutomaticallyCommandArguments(
        id: id,
      ),
    );
    return methodChannel.invokeCommand(command);
  }

  @override
  Future<void> focusManually(double width, double height, double x, double y) {
    final command = messages.Command(
      category: messages
          .CommandCategory.COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY,
      cameraControllerFocusManuallyArguments:
          messages.CameraControllerFocusManuallyCommandArguments(
        id: id,
        width: width,
        height: height,
        x: x,
        y: y,
      ),
    );
    return methodChannel.invokeCommand(command);
  }
}

class $CameraSelector implements CameraSelector {
  @override
  final CameraFacing facing;

  const $CameraSelector(this.facing);
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
}

class $ImageProxy implements ImageProxy {
  final String controllerId;
  final String id;
  @override
  final Uint8List data;
  @override
  final int width;
  @override
  final int height;

  const $ImageProxy(
    this.controllerId,
    this.id,
    this.data,
    this.width,
    this.height,
  );

  factory $ImageProxy.fromMessage(
    String controllerId,
    messages.ImageProxy imageProxy,
  ) {
    final id = imageProxy.id;
    final data = Uint8List.fromList(imageProxy.data);
    final width = imageProxy.width;
    final height = imageProxy.height;
    return $ImageProxy(controllerId, id, data, width, height);
  }

  @override
  Future<void> close() {
    final command = messages.Command(
      category: messages.CommandCategory.COMMAND_CATEGORY_IMAGE_PROXY_CLOSE,
      imageProxyCloseArguments: messages.ImageProxyCloseCommandArguments(
        controllerId: controllerId,
        id: id,
      ),
    );
    return methodChannel.invokeCommand(command);
  }
}
