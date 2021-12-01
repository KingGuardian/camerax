import 'dart:typed_data';

import 'camera_facing.dart';
import 'camera_selector.dart';
import 'camera_value.dart';
import 'event.dart';
import 'event_category.dart';
import 'image_proxy.dart';
import 'messages.pb.dart' as messages;
import 'method_category.dart';
import 'texture_value.dart';
import 'torch_value.dart';
import 'zoom_value.dart';

extension MethodCategoryX0 on MethodCategory {
  messages.MethodCategory get $category {
    return messages.MethodCategory.values[index];
  }
}

extension MethodCategoryX1 on messages.MethodCategory {
  MethodCategory get $category {
    return MethodCategory.values[value];
  }
}

extension CameraSelectorX0 on CameraSelector {
  messages.CameraSelector get $selector {
    return messages.CameraSelector(
      facing: facing.$facing,
    );
  }
}

extension CameraSelectorX1 on messages.CameraSelector {
  CameraSelector get $selector {
    return CameraSelector(
      facing: facing.$facing,
    );
  }
}

extension CameraFacingX0 on CameraFacing {
  messages.CameraFacing get $facing {
    return messages.CameraFacing.values[index];
  }
}

extension CameraFacingX1 on messages.CameraFacing {
  CameraFacing get $facing {
    return CameraFacing.values[value];
  }
}

extension CameraValueX on messages.CameraValue {
  CameraValue get $cameraValue {
    return CameraValue(
      uuid,
      textureValue.$textureValue,
      torchValue.$torchValue,
      zoomValue.$zoomValue,
    );
  }
}

extension TextureValueX on messages.TextureValue {
  TextureValue get $textureValue {
    return TextureValue(id, width, height, quarterTurns);
  }
}

extension TorchValueX on messages.TorchValue {
  TorchValue get $torchValue {
    return TorchValue(available, state);
  }
}

extension ZoomValueX on messages.ZoomValue {
  ZoomValue get $zoomValue {
    return ZoomValue(minimum, maximum, value);
  }
}

extension EventX on messages.Event {
  Event get $event {
    return Event(this);
  }
}

extension EventCategoryX on messages.EventCategory {
  EventCategory get $category {
    return EventCategory.values[value];
  }
}

extension ImageProxyX on messages.ImageProxy {
  ImageProxy get $imageProxy {
    final data = Uint8List.fromList(this.data);
    return ImageProxy(uuid, data, width, height);
  }
}
