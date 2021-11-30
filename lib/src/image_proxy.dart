import 'dart:typed_data';

import 'channels.dart';
import 'messages.dart' as messages;

class ImageProxy {
  final String _key;
  final Uint8List data;
  final int width;
  final int height;

  ImageProxy._(this._key, this.data, this.width, this.height);

  factory ImageProxy.fromByteArray(Uint8List byteArray) {
    final message = messages.ImageProxy.fromBuffer(byteArray);
    return ImageProxy._(
      message.key,
      Uint8List.fromList(message.data),
      message.width,
      message.height,
    );
  }

  Future<void> close() async {
    final command = messages.Command(
      key: _key,
      category: messages.CommandCategory.CLOSE_IMAGE_PROXY,
    ).writeToBuffer();
    await method.invokeMethod<void>('', command);
  }
}
