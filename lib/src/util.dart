import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'messages.pb.dart' as messages;

const namespace = 'yanshouwang.dev/camerax';
const method = MethodChannel('$namespace/method');
const event = EventChannel('$namespace/event');

final stream = event
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((data) => messages.EventArguments.fromBuffer(data));

extension MethodChannelX on MethodChannel {
  Future<T?> invokeByMethodArguments<T>(
    messages.MethodArguments methodArguments,
  ) {
    final arguments = methodArguments.writeToBuffer();
    return invokeMethod<T>('', arguments);
  }

  Future<List<T>?> invokeListByMethodArguments<T>(
    messages.MethodArguments methodArguments,
  ) {
    final arguments = methodArguments.writeToBuffer();
    return invokeListMethod<T>('', arguments);
  }
}
