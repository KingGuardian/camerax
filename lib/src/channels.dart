import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'messages.dart' as messages;

const namespace = 'yanshouwang.dev/camerax';
const methodChannel = MethodChannel('$namespace/method');
const eventChannel = EventChannel('$namespace/event');

final eventStream = eventChannel
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((bytes) => messages.Event.fromBuffer(bytes));

extension MethodChannelX on MethodChannel {
  Future<messages.Reply?> execute(messages.Command command) {
    const method = '';
    final arguments = command.writeToBuffer();
    return invokeMethod<Uint8List>(method, arguments).then((bytes) {
      if (bytes == null) {
        return null;
      } else {
        return messages.Reply.fromBuffer(bytes);
      }
    });
  }
}
