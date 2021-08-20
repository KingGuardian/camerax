part of device;

extension on comm.DisplayRotation {
  DeviceOrientation get mirror {
    switch (this) {
      case DisplayRotation.ROTATION_0:
        return DeviceOrientation.portraitUp;
      case DisplayRotation.ROTATION_90:
        return DeviceOrientation.landscapeRight;
      case DisplayRotation.ROTATION_180:
        return DeviceOrientation.portraitDown;
      case DisplayRotation.ROTATION_270:
        return DeviceOrientation.landscapeLeft;
      default:
        throw ArgumentError();
    }
  }
}
