import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'messages.pb.dart' as messages;

const namespace = 'yanshouwang.dev/camerax';
const methodChannel = MethodChannel('$namespace/method');
const eventChannel = EventChannel('$namespace/event');

final event = eventChannel
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((byteArray) => messages.Event.fromBuffer(byteArray));

extension MethodChannelX on MethodChannel {
  Future<T?> invokeCommand<T>(messages.Command command) {
    final arguments = command.writeToBuffer();
    return invokeMethod<T>('', arguments);
  }

  Future<List<T>?> invokeListCommand<T>(messages.Command command) {
    final arguments = command.writeToBuffer();
    return invokeListMethod<T>('', arguments);
  }

  Future<Map<K, V>?> invokeMapCommand<K, V>(messages.Command command) {
    final arguments = command.writeToBuffer();
    return invokeMapMethod<K, V>('', arguments);
  }
}
