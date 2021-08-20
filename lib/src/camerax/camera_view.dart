part of camerax;

class CameraView extends StatefulWidget {
  CameraView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CameraController controller;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late ValueNotifier<DeviceOrientation?> orientation;
  late StreamSubscription<DeviceOrientation> orientationSubscription;

  @override
  void initState() {
    super.initState();
    orientation = ValueNotifier(null);
    setup();
  }

  void setup() async {
    orientation.value = await device.orientation;
    orientationSubscription = device.orientationChanged
        .listen((orientation) => this.orientation.value = orientation);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller.cameraArgs,
      builder: buildCameraArgs,
    );
  }

  Widget buildCameraArgs(
      BuildContext context, CameraArgs? cameraArgs, Widget? child) {
    if (cameraArgs == null) {
      return buildPlaceHolder(context);
    } else {
      // 获取物理像素与逻辑像素的比值
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      final width = cameraArgs.size.width / devicePixelRatio;
      final height = cameraArgs.size.height / devicePixelRatio;
      return ValueListenableBuilder(
        valueListenable: orientation,
        builder: buildOrientation,
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color.fromARGB(255, 0, 0, 255),
          child: FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: width,
              height: height,
              child: Texture(
                textureId: cameraArgs.textureId,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget buildOrientation(
      BuildContext context, DeviceOrientation? orientation, Widget? child) {
    if (orientation == null) {
      return buildPlaceHolder(context);
    } else {
      return RotatedBox(
        quarterTurns: orientation.quarterTurns,
        child: child,
      );
    }
  }

  Widget buildPlaceHolder(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0),
    );
  }

  @override
  void dispose() {
    orientationSubscription.cancel();
    orientation.dispose();
    super.dispose();
  }
}
