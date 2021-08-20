import 'package:camerax/camerax.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

class AnalyzerView extends StatefulWidget {
  @override
  _AnalyzerViewState createState() => _AnalyzerViewState();
}

class _AnalyzerViewState extends State<AnalyzerView>
    with SingleTickerProviderStateMixin {
  late CameraController cameraController;
  late AnimationController animationConrtroller;
  late Animation<double> offsetAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(CameraSelector.DEFAULT_BACK_CAMERA);
    animationConrtroller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    offsetAnimation = Tween(begin: 0.2, end: 0.8).animate(animationConrtroller);
    opacityAnimation =
        CurvedAnimation(parent: animationConrtroller, curve: OpacityCurve());
    setup();
  }

  Future<void> setup() async {
    unawaited(animationConrtroller.repeat());
    await cameraController.bind();
    // try {
    //   final barcode = await cameraController.barcodes.first;
    //   display(barcode);
    // } catch (e) {
    //   print(e);
    // }
  }

  // void display(Barcode barcode) {
  //   Navigator.of(context).popAndPushNamed('display', arguments: barcode);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 相机
          CameraView(controller: cameraController),
          // 扫描线
          AnimatedLine(
            offsetAnimation: offsetAnimation,
            opacityAnimation: opacityAnimation,
          ),
          // 返回按钮
          Positioned(
            left: 24.0,
            top: 32.0,
            child: IconButton(
              icon: Icon(Icons.cancel, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // 闪光灯
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 80.0),
            child: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: buildTorchState,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTorchState(BuildContext context, bool? state, Widget? child) {
    final color = (state != null && state) ? Colors.white : Colors.grey;
    final action = state == null ? null : () => torch(!state);
    return IconButton(
      icon: Icon(Icons.bolt, color: color),
      iconSize: 32.0,
      onPressed: action,
    );
  }

  Future<void> torch(bool state) async {
    await cameraController.torch(state);
  }

  @override
  void dispose() {
    animationConrtroller.dispose();
    cameraController.unbind();
    super.dispose();
  }
}

class OpacityCurve extends Curve {
  @override
  double transform(double t) {
    if (t < 0.1) {
      return t * 10;
    } else if (t <= 0.9) {
      return 1.0;
    } else {
      return (1.0 - t) * 10;
    }
  }
}

class AnimatedLine extends AnimatedWidget {
  final Animation offsetAnimation;
  final Animation opacityAnimation;

  AnimatedLine(
      {Key? key, required this.offsetAnimation, required this.opacityAnimation})
      : super(key: key, listenable: offsetAnimation);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: LinePainter(offsetAnimation.value),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double offset;

  LinePainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final radius = size.width * 0.45;
    final dx = size.width / 2.0;
    final center = Offset(dx, radius);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..isAntiAlias = true
      ..shader = RadialGradient(
        colors: [Colors.green, Colors.green.withOpacity(0.0)],
        radius: 0.5,
      ).createShader(rect);
    canvas.translate(0.0, size.height * offset);
    canvas.scale(1.0, 0.1);
    final top = Rect.fromLTRB(0, 0, size.width, radius);
    canvas.clipRect(top);
    canvas.drawCircle(center, radius, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
