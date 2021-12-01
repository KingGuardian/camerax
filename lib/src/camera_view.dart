import 'package:flutter/widgets.dart';

import 'camera_controller.dart';
import 'camera_value.dart';

class CameraView extends StatelessWidget {
  final CameraController controller;
  final BoxFit fit;
  final FilterQuality filterQuality;

  const CameraView({
    Key? key,
    required this.controller,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CameraValue?>(
      valueListenable: controller,
      builder: (context, cameraValue, child) {
        if (cameraValue == null) {
          return Container(
            color: const Color.fromARGB(255, 0, 0, 0),
          );
        } else {
          // 获取物理像素与逻辑像素的比值
          final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
          final textureValue = cameraValue.textureValue;
          final width = textureValue.width / devicePixelRatio;
          final height = textureValue.height / devicePixelRatio;
          return RotatedBox(
            quarterTurns: textureValue.quarterTurns,
            child: FittedBox(
              fit: fit,
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: width,
                height: height,
                child: Texture(
                  textureId: textureValue.id,
                  filterQuality: filterQuality,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
