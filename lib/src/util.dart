import 'dart:typed_data';

import 'package:camerax/src/communication.dart';
import 'package:flutter/services.dart';

const method = MethodChannel('yanshouwang.dev/camerax/method');
const event = EventChannel('yanshouwang.dev/camerax/event');

final stream = event
    .receiveBroadcastStream()
    .cast<Uint8List>()
    .map((binaries) => Message.fromBuffer(binaries));
