part of camerax;

abstract class CameraController {
  ValueListenable<CameraArgs?> get cameraArgs;
  ValueListenable<bool?> get torchState;

  Future<void> bind();
  Future<void> unbind();
  Future<void> torch(bool state);

  factory CameraController(CameraSelector selector) =>
      _CameraController(selector);
}

class _CameraController implements CameraController {
  _CameraController(this.selector)
      : cameraArgs = ValueNotifier(null),
        torchState = ValueNotifier(null);

  final CameraSelector selector;
  @override
  final ValueNotifier<CameraArgs?> cameraArgs;
  @override
  final ValueNotifier<bool?> torchState;

  late StreamSubscription<bool> torchStateSubscription;

  late String key;

  @override
  Future<void> bind() async {
    final message = comm.Message(
      category: comm.MessageCategory.CAMERA_CONTROLLER_BIND,
      bindArgs: comm.BindArgs(selector: selector.mirror),
    ).writeToBuffer();
    final binding = await method
        .invokeMethod<Uint8List>('', message)
        .then((binaries) => comm.CameraBinding.fromBuffer(binaries!));
    // 绑定参数赋值
    key = binding.key;
    cameraArgs.value = binding.cameraArgs.mirror;
    torchState.value = binding.torchState;
    // 开始监听闪光灯状态变化
    torchStateSubscription = stream
        .where((event) =>
            event.category == comm.MessageCategory.TORCH_STATE_CHANGED &&
            event.torchArgs.key == key)
        .map((torchArgs) => torchArgs.torchArgs.state)
        .listen((state) => torchState.value = state);
  }

  @override
  Future<void> unbind() async {
    // 结束监听闪光灯状态变化
    await torchStateSubscription.cancel();
    final message = comm.Message(
      category: comm.MessageCategory.CAMERA_CONTROLLER_UNBIND,
      unbindArgs: comm.UnbindArgs(key: key),
    ).writeToBuffer();
    await method.invokeMethod<void>('', message);
    torchState.dispose();
    cameraArgs.dispose();
  }

  @override
  Future<void> torch(bool state) async {
    final message = comm.Message(
      category: comm.MessageCategory.CAMERA_CONTROLLER_TORCH,
      torchArgs: comm.TorchArgs(
        key: key,
        state: state,
      ),
    ).writeToBuffer();
    await method.invokeMethod('', message);
  }
}
