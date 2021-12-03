import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'event.dart';
import 'method_arguments.dart';

const namespace = 'yanshouwang.dev/camerax';
const methodChannel = MethodChannel('$namespace/method');
const eventChannel = EventChannel('$namespace/event');

final eventStream = eventChannel
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((protobuf) => Event.fromProtobuf(protobuf));

extension MethodChannelX on MethodChannel {
  Future<T?> invokeByMethodArguments<T>(MethodArguments methodArguments) async {
    final arguments = methodArguments.toProtobuf();
    return invokeMethod<T>('', arguments);
  }

  Future<List<T>?> invokeListByMethodArguments<T>(
      MethodArguments methodArguments) async {
    final arguments = methodArguments.toProtobuf();
    return invokeListMethod<T>('', arguments);
  }
}
