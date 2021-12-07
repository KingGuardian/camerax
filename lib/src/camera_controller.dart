import 'dart:async';

import 'package:flutter/foundation.dart';

import 'camera_implementation.dart';
import 'camera_selector.dart';
import 'camera_value.dart';
import 'image_proxy.dart';

abstract class CameraController {
  ValueListenable<CameraValue?> get value;

  factory CameraController({required CameraSelector selector}) =>
      $CameraController(selector);

  Stream<ImageProxy> get imageProxy;

  Future<void> open();
  Future<void> close();
  Future<void> torch(bool state);
  Future<void> zoom(double value);
  void dispose();
}
