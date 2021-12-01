import 'dart:typed_data';

import 'event_category.dart';
import 'image_proxy.dart';
import 'messages.pb.dart' as messages;
import 'util.dart';

class Event {
  final messages.Event event;

  EventCategory get category => event.category.$category;
  int get quarterTurns => event.quarterTurns;
  String get uuid => event.uuid;
  bool get torchState => event.torchState;
  double get zoomValue => event.zoomValue;
  ImageProxy get imageProxy => event.imageProxy.$imageProxy;

  Event(this.event);

  factory Event.fromProtobuf(Uint8List protobuf) {
    return messages.Event.fromBuffer(protobuf).$event;
  }
}
