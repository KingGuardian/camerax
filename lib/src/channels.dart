import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'event.dart';

const namespace = 'yanshouwang.dev/camerax';
const methodChannel = MethodChannel('$namespace/method');
const eventChannel = EventChannel('$namespace/event');

final eventStream = eventChannel
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((protobuf) => Event.fromProtobuf(protobuf));
