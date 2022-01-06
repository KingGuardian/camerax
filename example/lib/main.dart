import 'dart:async';
import 'dart:developer' as developer;

import 'package:camerax/camerax.dart';
import 'package:camerax_example/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final cameraController = CameraController(CameraSelector.back);

void main() {
  runZonedGuarded(onStartup, onCrashed);
}

void onStartup() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final orientations = [DeviceOrientation.portraitUp];
  // await SystemChrome.setPreferredOrientations(orientations);
  final style = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(style);
  const app = MyApp();
  runApp(app);
}

void onCrashed(Object error, StackTrace stack) {
  final message = '$error\n$stack';
  developer.log(message);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        platform: TargetPlatform.iOS,
      ),
      routes: {
        'home': (context) => const HomeView(),
        'scanner': (context) => const ScannerView(),
        'analysis': (context) => const AnalysisView(),
      },
      initialRoute: 'home',
    );
  }
}
