import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const method = MethodChannel('yanshouwang.dev/camerax/method');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    method.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    method.setMockMethodCallHandler(null);
  });
}
