part of camerax;

class CameraSelector {
  const CameraSelector(this.facing);

  final CameraFacing facing;

  static const CameraSelector DEFAULT_BACK_CAMERA =
      CameraSelector(CameraFacing.back);
  static const CameraSelector DEFAULT_FRONT_CAMERA =
      CameraSelector(CameraFacing.front);
}
