import 'dart:typed_data';

import 'messages.dart' as messages;

class CameraValue {
  final String _key;
  final TextureValue textureValue;
  final TorchValue torchValue;
  final ZoomValue zoomValue;

  CameraValue._(
    this._key,
    this.textureValue,
    this.torchValue,
    this.zoomValue,
  );

  factory CameraValue.fromByteArray(Uint8List byteArray) {
    final value = messages.CameraValue.fromBuffer(byteArray);
    return CameraValue._(
      value.key,
      value.textureValue,
      value.torchValue,
      value.zoomValue,
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
    return CameraValue._(
      _key,
      textureValue,
      torchValue,
      zoomValue,
    );
  }
}
