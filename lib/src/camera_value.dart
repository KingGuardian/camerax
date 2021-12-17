import 'focus_mode.dart';
import 'texture_value.dart';
import 'torch_value.dart';
import 'zoom_value.dart';

abstract class CameraValue {
  TextureValue get textureValue;
  TorchValue get torchValue;
  ZoomValue get zoomValue;
  FocusMode get focusMode;
}
