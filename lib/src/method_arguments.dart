import 'dart:typed_data';

import 'package:camerax/camerax.dart';

import 'messages.pb.dart' as messages;
import 'method_category.dart';
import 'util.dart';

class MethodArguments {
  final messages.MethodArguments methodArguments;

  MethodCategory get category => methodArguments.category.$category;
  CameraSelector get selector => methodArguments.selector.$selector;
  String get uuid => methodArguments.uuid;
  bool get torchState => methodArguments.torchState;
  double get zoomValue => methodArguments.zoomValue;

  MethodArguments({
    required MethodCategory category,
    CameraSelector? selector,
    String? uuid,
    bool? torchState,
    double? zoomValue,
  }) : methodArguments = messages.MethodArguments(
          category: category.$category,
          selector: selector?.$selector,
          uuid: uuid,
          torchState: torchState,
          zoomValue: zoomValue,
        );

  Uint8List toProtobuf() {
    return methodArguments.writeToBuffer();
  }
}
