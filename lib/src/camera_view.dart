import 'package:camerax/camerax.dart';
import 'package:flutter/widgets.dart';

import 'camera_value.dart';
import 'channels.dart';
import 'messages.dart' as messages;

class CameraView extends StatelessWidget {
  final CameraController cameraController;
  final BoxFit fit;
  final FilterQuality filterQuality;

  const CameraView({
    Key? key,
    required this.cameraController,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // 监听屏幕方向
    final stream = eventStream
        .where((event) =>
    event.category ==
        messages.EventCategory.EVENT_CATEGORY_QUARTER_TURNS_CHANGED)
        .map((event) => event.quarterTurnsChangedArguments.quarterTurns);

    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        final newQuarterTurns = snapshot.data;
        if (newQuarterTurns == null) {
          // 校正屏幕方向
          final command = messages.Command(
            category:
                messages.CommandCategory.COMMAND_CATEGORY_GET_QUARTER_TURNS,
          );
          final future = methodChannel
              .invokeCommand(command)
              .then((reply) => reply!.getQuarterTurnsArguments.quarterTurns);
          return FutureBuilder<int>(
            initialData: 0,
            future: future,
            builder: (context, snapshot) {
              final oldQuarterTurns = snapshot.data!;
              return buildWhenQuarterTurnsChanged(context, oldQuarterTurns);
            },
          );
        } else {
          return buildWhenQuarterTurnsChanged(context, newQuarterTurns);
        }
      },
    );
  }

  Widget buildWhenQuarterTurnsChanged(BuildContext context, int quarterTurns) {
    // 获取物理像素与逻辑像素的比值
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = cameraController.value.textureWidth / devicePixelRatio;
    final height = cameraController.value.textureHeight / devicePixelRatio;
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: FittedBox(
        fit: fit,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: width,
          height: height,
          child: Texture(
            textureId: cameraController.value.textureId,
            filterQuality: filterQuality,
          ),
        ),
      ),
    );
  }
}
