import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'event.dart';

const namespace = 'yanshouwang.dev/camerax';
const method = MethodChannel('$namespace/method');
const event = EventChannel('$namespace/event');

final stream = event
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((protobuf) => Event.fromProtobuf(protobuf));
