part of device;

const device = _Device();

abstract class Device {
  Future<DeviceOrientation> get orientation;
  Stream<DeviceOrientation> get orientationChanged;
}

class _Device implements Device {
  const _Device();

  @override
  Future<DeviceOrientation> get orientation {
    final message = comm.Message(
      category: comm.MessageCategory.DEVICE_GET_ROTATION,
    ).writeToBuffer();
    return method
        .invokeMethod<int>('', message)
        .then((value) => comm.DisplayRotation.valueOf(value!)!)
        .then((rotation) => rotation.mirror);
  }

  @override
  Stream<DeviceOrientation> get orientationChanged => stream
      .where((message) =>
          message.category == MessageCategory.DEVICE_ROTATION_CHANGED)
      .map((message) => message.rotation.mirror);
}
