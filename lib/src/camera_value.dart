import 'dart:typed_data';

import 'messages.pb.dart' as messages;
import 'texture_value.dart';
import 'torch_value.dart';
import 'util.dart';
import 'zoom_value.dart';

class CameraValue {
  final String uuid;
  final TextureValue textureValue;
  final TorchValue torchValue;
  final ZoomValue zoomValue;

  const CameraValue(
    this.uuid,
    this.textureValue,
    this.torchValue,
    this.zoomValue,
  );

  factory CameraValue.fromProtobuf(Uint8List protoBuffer) {
    return messages.CameraValue.fromBuffer(protoBuffer).$cameraValue;
  }

  CameraValue copyWith({
    TextureValue? textureValue,
    TorchValue? torchValue,
    ZoomValue? zoomValue,
  }) {
    textureValue ??= this.textureValue;
    torchValue ??= this.torchValue;
    zoomValue ??= this.zoomValue;
    return CameraValue(
      uuid,
      textureValue,
      torchValue,
      zoomValue,
    );
  }
}
