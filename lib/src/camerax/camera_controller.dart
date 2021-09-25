part of camerax;

abstract class CameraController {
  Stream<bool> get torchState;
  Stream<Uint8List> get analysis;

  Future<CameraInfo> bind();
  Future<void> torch(bool state);
  // Future<void> capture();
  Future<void> unbind();

  factory CameraController(CameraSelector selector) =>
      _CameraController(selector);
}

class _CameraController implements CameraController {
  _CameraController(this.selector);

  final CameraSelector selector;

  @override
  Stream<bool> get torchState => stream
      .where((message) =>
          message.key == hashCode &&
          message.category == comm.MessageCategory.TORCH_EVENT)
      .map((message) => message.torchState);

  @override
  Stream<Uint8List> get analysis => stream
      .where((message) =>
          message.key == hashCode &&
          message.category == comm.MessageCategory.ANALYSIS_EVENT)
      .map((message) => message.analysis as Uint8List);

  @override
  Future<CameraInfo> bind() async {
    final arguments = comm.Message(
      key: hashCode,
      category: comm.MessageCategory.BIND,
      bindArgs: comm.BindArgs(selector: selector.mirror),
    ).writeToBuffer();
    final info = await method
        .invokeMethod<Uint8List>('', arguments)
        .then((binaries) => binaries!.cameraInfo);
    return info;
  }

  @override
  Future<void> torch(bool state) async {
    final arguments = comm.Message(
      key: hashCode,
      category: comm.MessageCategory.TORCH,
      torchState: state,
    ).writeToBuffer();
    await method.invokeMethod('', arguments);
  }

  @override
  Future<void> unbind() async {
    final arguments = comm.Message(
      key: hashCode,
      category: comm.MessageCategory.UNBIND,
    ).writeToBuffer();
    await method.invokeMethod<void>('', arguments);
  }
}
