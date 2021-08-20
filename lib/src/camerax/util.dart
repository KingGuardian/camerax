part of camerax;

extension on CameraSelector {
  comm.CameraSelector get mirror => comm.CameraSelector(
        facing: comm.CameraFacing.valueOf(facing.index),
      );
}

extension on DeviceOrientation {
  int get quarterTurns {
    switch (this) {
      case DeviceOrientation.portraitUp:
        return 0;
      case DeviceOrientation.landscapeRight:
        return 1;
      case DeviceOrientation.portraitDown:
        return 2;
      case DeviceOrientation.landscapeLeft:
        return 3;
      default:
        throw ArgumentError();
    }
  }
}

extension on comm.CameraArgs {
  CameraArgs get mirror => CameraArgs(textureId, size.mirror);
}

extension on comm.CameraSize {
  CameraSize get mirror => CameraSize(width, height);
}
