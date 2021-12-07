import 'camera_facing.dart';
import 'camera_implementation.dart';

abstract class CameraSelector {
  CameraFacing get facing;

  static const CameraSelector back = $CameraSelector(CameraFacing.back);
  static const CameraSelector front = $CameraSelector(CameraFacing.front);
}
