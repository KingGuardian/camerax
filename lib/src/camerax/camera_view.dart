part of camerax;

class CameraView extends StatefulWidget {
  CameraView({
    Key? key,
    required this.controller,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final CameraController controller;
  final BoxFit fit;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late ValueNotifier<TextureInfo?> textureInfo;
  late StreamSubscription<TextureInfo> textureInfoSubscription;

  @override
  void initState() {
    super.initState();
    textureInfo = ValueNotifier(null);
    setup();
  }

  void setup() async {
    textureInfoSubscription = stream
        .where((message) =>
            message.key == widget.controller.hashCode &&
            message.category == comm.MessageCategory.TEXTURE_INFO_EVENT)
        .map((message) => message.textureInfo.mirror)
        .listen((textureInfo) => this.textureInfo.value = textureInfo);
    // 监听方向
    final arguments = comm.Message(
      key: hashCode,
      category: comm.MessageCategory.TEXTURE_INFO,
    ).writeToBuffer();
    await method.invokeMethod<void>('', arguments);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: textureInfo,
      builder: buildTexture,
    );
  }

  Widget buildTexture(
      BuildContext context, TextureInfo? textureInfo, Widget? child) {
    if (textureInfo == null) {
      return buildPlaceHolder(context);
    } else {
      // 获取物理像素与逻辑像素的比值
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      final width = textureInfo.size.width / devicePixelRatio;
      final height = textureInfo.size.height / devicePixelRatio;
      return RotatedBox(
        quarterTurns: textureInfo.quarterTurns,
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color.fromARGB(255, 0, 0, 0),
          child: FittedBox(
            fit: widget.fit,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: width,
              height: height,
              child: Texture(
                textureId: textureInfo.id,
              ),
            ),
          ),
        ),
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
    textureInfoSubscription.cancel();
    textureInfo.dispose();
    super.dispose();
  }
}
