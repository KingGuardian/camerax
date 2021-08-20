///
//  Generated code. Do not modify.
//  source: communication.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MessageCategory extends $pb.ProtobufEnum {
  static const MessageCategory CAMERA_CONTROLLER_BIND = MessageCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMERA_CONTROLLER_BIND');
  static const MessageCategory CAMERA_CONTROLLER_UNBIND = MessageCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMERA_CONTROLLER_UNBIND');
  static const MessageCategory CAMERA_CONTROLLER_TORCH = MessageCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMERA_CONTROLLER_TORCH');
  static const MessageCategory CAMERA_ARGS_CHANGED = MessageCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMERA_ARGS_CHANGED');
  static const MessageCategory TORCH_STATE_CHANGED = MessageCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TORCH_STATE_CHANGED');
  static const MessageCategory DEVICE_GET_ROTATION = MessageCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DEVICE_GET_ROTATION');
  static const MessageCategory DEVICE_ROTATION_CHANGED = MessageCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DEVICE_ROTATION_CHANGED');

  static const $core.List<MessageCategory> values = <MessageCategory> [
    CAMERA_CONTROLLER_BIND,
    CAMERA_CONTROLLER_UNBIND,
    CAMERA_CONTROLLER_TORCH,
    CAMERA_ARGS_CHANGED,
    TORCH_STATE_CHANGED,
    DEVICE_GET_ROTATION,
    DEVICE_ROTATION_CHANGED,
  ];

  static final $core.Map<$core.int, MessageCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageCategory? valueOf($core.int value) => _byValue[value];

  const MessageCategory._($core.int v, $core.String n) : super(v, n);
}

class CameraFacing extends $pb.ProtobufEnum {
  static const CameraFacing FRONT = CameraFacing._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FRONT');
  static const CameraFacing BACK = CameraFacing._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BACK');

  static const $core.List<CameraFacing> values = <CameraFacing> [
    FRONT,
    BACK,
  ];

  static final $core.Map<$core.int, CameraFacing> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CameraFacing? valueOf($core.int value) => _byValue[value];

  const CameraFacing._($core.int v, $core.String n) : super(v, n);
}

class DisplayRotation extends $pb.ProtobufEnum {
  static const DisplayRotation ROTATION_0 = DisplayRotation._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATION_0');
  static const DisplayRotation ROTATION_90 = DisplayRotation._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATION_90');
  static const DisplayRotation ROTATION_180 = DisplayRotation._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATION_180');
  static const DisplayRotation ROTATION_270 = DisplayRotation._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATION_270');

  static const $core.List<DisplayRotation> values = <DisplayRotation> [
    ROTATION_0,
    ROTATION_90,
    ROTATION_180,
    ROTATION_270,
  ];

  static final $core.Map<$core.int, DisplayRotation> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DisplayRotation? valueOf($core.int value) => _byValue[value];

  const DisplayRotation._($core.int v, $core.String n) : super(v, n);
}

