part of camerax;

extension on CameraSelector {
  comm.CameraSelector get mirror => comm.CameraSelector(
        facing: comm.CameraFacing.valueOf(facing.index),
      );
}

extension on comm.CameraInfo {
  CameraInfo get mirror => CameraInfo(hasTorch);
}

extension on comm.TextureInfo {
  TextureInfo get mirror => TextureInfo(id, size.mirror, quarterTurns);
}

extension on comm.TextureSize {
  TextureSize get mirror => TextureSize(width, height);
}

extension on Uint8List {
  CameraInfo get cameraInfo => comm.CameraInfo.fromBuffer(this).mirror;
  TextureInfo get textureInfo => comm.TextureInfo.fromBuffer(this).mirror;
}
