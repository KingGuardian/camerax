import 'package:flutter/widgets.dart';

import 'camera_controller.dart';
import 'camera_value.dart';
import 'focus_mode.dart';

class CameraView extends StatelessWidget {
  final CameraController controller;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final FocusMode focusMode;

  const CameraView({
    Key? key,
    required this.controller,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
    this.focusMode = FocusMode.auto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CameraValue?>(
      valueListenable: controller.valueListenable,
      builder: (context, cameraValue, child) {
        if (cameraValue == null) {
          return Container(
            color: const Color.fromARGB(255, 0, 0, 0),
          );
        } else {
          // 恢复自动对焦
          if (focusMode == FocusMode.auto &&
              cameraValue.focusMode == FocusMode.manual) {
            controller.focusAutomatically();
          }
          // 获取物理像素与逻辑像素的比值
          final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
          final textureValue = cameraValue.textureValue;
          final width = textureValue.width / devicePixelRatio;
          final height = textureValue.height / devicePixelRatio;
          final quarterTurns = textureValue.quarterTurns;
          return RotatedBox(
            quarterTurns: quarterTurns,
            child: FittedBox(
              fit: fit,
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: width,
                height: height,
                child: GestureDetector(
                  onTapUp: (details) async {
                    if (focusMode == FocusMode.auto) {
                      return;
                    }
                    final dx = details.localPosition.dx;
                    final dy = details.localPosition.dy;
                    final Size size;
                    final Offset offset;
                    switch (quarterTurns) {
                      case 0:
                        size = Size(width, height);
                        offset = Offset(dx, dy);
                        break;
                      case 1:
                        size = Size(height, width);
                        offset = Offset(height - dy, dx);
                        break;
                      case 2:
                        size = Size(width, height);
                        offset = Offset(width - dx, height - dy);
                        break;
                      case 3:
                        size = Size(height, width);
                        offset = Offset(dy, width - dx);
                        break;
                      default:
                        throw UnimplementedError();
                    }
                    await controller.focusManually(size, offset);
                  },
                  child: Texture(
                    textureId: textureValue.id,
                    filterQuality: filterQuality,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
