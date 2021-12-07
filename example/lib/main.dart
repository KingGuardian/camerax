import 'dart:async';
import 'dart:developer' as developer;

import 'package:camerax/camerax.dart';
import 'package:camerax_example/views.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runZonedGuarded(onStartup, onCrashed);
}

final myAppKey = GlobalKey<MyAppState>();

void onStartup() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final orientations = [DeviceOrientation.portraitUp];
  // await SystemChrome.setPreferredOrientations(orientations);
  final style = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(style);
  final app = MyApp(
    key: myAppKey,
  );
  runApp(app);
}

void onCrashed(Object error, StackTrace stack) {
  final message = '$error\n$stack';
  developer.log(message);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(
      selector: CameraSelector.back,
    );
  }

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

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
