import 'camera_facing.dart';

class CameraSelector {
  final CameraFacing facing;

  const CameraSelector({required this.facing});

  static const CameraSelector back = CameraSelector(
    facing: CameraFacing.back,
  );
  static const CameraSelector front = CameraSelector(
    facing: CameraFacing.front,
  );
}
