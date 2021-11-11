import 'package:camerax/camerax.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView>
    with SingleTickerProviderStateMixin {
  late CameraController cameraController;
  late AnimationController animationConrtroller;
  late Animation<double> offsetAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController();
    animationConrtroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    setup();
  }

  Future<void> setup() async {
    await cameraController.open();
    animationConrtroller.repeat();
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
    offsetAnimation = Tween(begin: 0.2, end: 0.8).animate(animationConrtroller);
    opacityAnimation = CurvedAnimation(
      parent: animationConrtroller,
      curve: OpacityCurve(),
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 相机
          CameraView(controller: cameraController),
          // 扫描线
          AnimatedBuilder(
            animation: animationConrtroller,
            builder: (context, childe) {
              return Opacity(
                opacity: opacityAnimation.value,
                child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: LinePainter(offsetAnimation.value),
                ),
              );
            },
          ),
          // 返回按钮
          Positioned(
            left: 24.0,
            top: 32.0,
            child: IconButton(
              icon: const Icon(Icons.cancel, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // 闪光灯
          Container(
            margin: const EdgeInsets.only(bottom: 80.0),
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<CameraValue?>(
              valueListenable: cameraController,
              builder: (context, cameraValue, child) {
                final torchAvailable =
                    cameraValue?.torchValue.available ?? false;
                final torchState = cameraValue?.torchValue.state ?? false;
                final color = torchState ? Colors.white : Colors.grey;
                return IconButton(
                  icon: Icon(Icons.bolt, color: color),
                  iconSize: 32.0,
                  onPressed: torchAvailable
                      ? () async {
                          await cameraController.torch(torchState);
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationConrtroller.dispose();
    cameraController.close();
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
