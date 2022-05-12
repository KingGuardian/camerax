import 'messages.dart' as messages;

class CameraValue {
  final int textureId;
  final int textureWidth;
  final int  textureHeight;
  final bool torchAvailable;
  final double zoomMinimum;
  final double zoomMaximum;

  const CameraValue({required this.textureId, required this.textureWidth, required this.textureHeight, this.torchAvailable = false, this.zoomMaximum = 0, this.zoomMinimum = 0});

  const CameraValue.generateDefault() : this(textureId: 0, textureWidth: 0, textureHeight: 0, torchAvailable: false, zoomMinimum: 0, zoomMaximum: 0);

  copyWith({int? textureId, int? textureWidth, int? textureHeight, bool? torchAvailable, double? zoomMaximum, double? zoomMinimum}) {
    return CameraValue(textureId: textureId ?? this.textureId ,
        textureWidth: textureWidth ?? this.textureWidth,
        textureHeight: textureHeight ?? this.textureHeight,
        torchAvailable: torchAvailable ?? this.torchAvailable,
        zoomMaximum: zoomMaximum ?? this.zoomMaximum,
        zoomMinimum: zoomMinimum ?? this.zoomMinimum,
    );
  }

  copyWithMessage({messages.CameraValue? cameraValue}) {
    return CameraValue(textureId: cameraValue?.textureId ?? textureId,
      textureWidth: cameraValue?.textureWidth ?? textureWidth,
      textureHeight: cameraValue?.textureHeight ?? textureHeight,
      torchAvailable: cameraValue?.torchAvailable ?? torchAvailable,
      zoomMinimum: cameraValue?.zoomMinimum ?? zoomMinimum,
      zoomMaximum: cameraValue?.zoomMaximum ?? zoomMaximum,
    );
  }

  factory CameraValue.fromMessage(messages.CameraValue cameraValue) {
    final textureId = cameraValue.textureId;
    final textureWidth = cameraValue.textureWidth;
    final textureHeight = cameraValue.textureHeight;
    final torchAvailable = cameraValue.torchAvailable;
    final zoomMinimum = cameraValue.zoomMinimum;
    final zoomMaximum = cameraValue.zoomMaximum;
    return CameraValue(
      textureId: textureId,
      textureWidth: textureWidth,
      textureHeight: textureHeight,
      torchAvailable: torchAvailable,
      zoomMinimum: zoomMinimum,
      zoomMaximum: zoomMaximum,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CameraValue &&
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
