import 'package:camerax_example/views.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
    return MaterialApp(
      theme: ThemeData.light().copyWith(platform: TargetPlatform.iOS),
      routes: {
        'home': (context) => HomeView(),
        'analyze': (context) => AnalyzerView(),
        'display': (context) => DisplayView(),
      },
      initialRoute: 'home',
    );
  }
}
