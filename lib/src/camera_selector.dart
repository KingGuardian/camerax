import 'dart:typed_data';

import 'camera_facing.dart';
import 'messages.dart' as messages;

class CameraSelector {
  final CameraFacing facing;

  const CameraSelector({required this.facing});

  Uint8List toByteArray() {
    final facing = messages.CameraFacing.valueOf(this.facing.index);
    final selector = messages.CameraSelector(
      facing: facing,
    );
    return selector.writeToBuffer();
  }

  static const CameraSelector back = CameraSelector(
    facing: CameraFacing.back,
  );
  static const CameraSelector front = CameraSelector(
    facing: CameraFacing.front,
  );
}
