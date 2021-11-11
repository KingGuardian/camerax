import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'messages.dart' as messages;

const namespace = 'yanshouwang.dev/camerax';
const method = MethodChannel('$namespace/method');
const event = EventChannel('$namespace/event');

final stream = event
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((byteArray) => messages.Event.fromBuffer(byteArray));
