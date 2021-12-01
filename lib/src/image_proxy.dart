import 'dart:typed_data';

import 'channels.dart';
import 'method_arguments.dart';
import 'method_category.dart';

class ImageProxy {
  final String uuid;
  final Uint8List data;
  final int width;
  final int height;

  const ImageProxy(
    this.uuid,
    this.data,
    this.width,
    this.height,
  );

  Future<void> close() async {
    final arguments = MethodArguments(
      category: MethodCategory.imageProxyClose,
      uuid: uuid,
    ).toProtobuf();
    await methodChannel.invokeMethod<void>('', arguments);
  }
}
