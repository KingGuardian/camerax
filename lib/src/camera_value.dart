import 'dart:typed_data';

import 'messages.pb.dart' as messages;
import 'texture_value.dart';
import 'torch_value.dart';
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
    final message = messages.CameraValue.fromBuffer(protoBuffer);
    final uuid = message.uuid;
    final textureValue = TextureValue(
      message.textureValue.id,
      message.textureValue.width,
      message.textureValue.height,
      message.textureValue.quarterTurns,
    );
    final torchValue = TorchValue(
      message.torchValue.available,
      message.torchValue.state,
    );
    final zoomValue = ZoomValue(
      message.zoomValue.minimum,
      message.zoomValue.maximum,
      message.zoomValue.value,
    );
    return CameraValue(
      uuid,
      textureValue,
      torchValue,
      zoomValue,
    );
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
