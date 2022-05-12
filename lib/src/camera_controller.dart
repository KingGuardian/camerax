import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'camera_implementation.dart';
import 'camera_selector.dart';
import 'camera_value.dart';
import 'image_proxy.dart';

abstract class CameraController extends ValueNotifier<CameraValue> {

  CameraController() : super(const CameraValue.generateDefault());

  factory CameraController.fromSelector(CameraSelector selector) =>
      $CameraController(selector);

  Stream<ImageProxy> get imageStream;

  Future<bool> requestPermission();
  Future<void> bind();
  Future<void> unbind();
  Future<void> torch(bool state);
  Future<void> zoom(double value);
  Future<void> focusAutomatically();
  Future<void> focusManually(double width, double height, double x, double y);
}
