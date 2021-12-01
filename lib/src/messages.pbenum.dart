///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MethodCategory extends $pb.ProtobufEnum {
  static const MethodCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN = MethodCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN');
  static const MethodCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE = MethodCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE');
  static const MethodCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH = MethodCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH');
  static const MethodCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM = MethodCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM');
  static const MethodCategory COMMAND_CATEGORY_IMAGE_PROXY_CLOSE = MethodCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_IMAGE_PROXY_CLOSE');

  static const $core.List<MethodCategory> values = <MethodCategory> [
    COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM,
    COMMAND_CATEGORY_IMAGE_PROXY_CLOSE,
  ];

  static final $core.Map<$core.int, MethodCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MethodCategory? valueOf($core.int value) => _byValue[value];

  const MethodCategory._($core.int v, $core.String n) : super(v, n);
}

class CameraFacing extends $pb.ProtobufEnum {
  static const CameraFacing CAMERA_FACING_BACK = CameraFacing._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMERA_FACING_BACK');
  static const CameraFacing CAMERA_FACING_FRONT = CameraFacing._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMERA_FACING_FRONT');

  static const $core.List<CameraFacing> values = <CameraFacing> [
    CAMERA_FACING_BACK,
    CAMERA_FACING_FRONT,
  ];

  static final $core.Map<$core.int, CameraFacing> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CameraFacing? valueOf($core.int value) => _byValue[value];

  const CameraFacing._($core.int v, $core.String n) : super(v, n);
}

class EventCategory extends $pb.ProtobufEnum {
  static const EventCategory EVENT_CATEGORY_QUARTER_TURNS = EventCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EVENT_CATEGORY_QUARTER_TURNS');
  static const EventCategory EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE = EventCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE');
  static const EventCategory EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE = EventCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE');
  static const EventCategory EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY = EventCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY');

  static const $core.List<EventCategory> values = <EventCategory> [
    EVENT_CATEGORY_QUARTER_TURNS,
    EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE,
    EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE,
    EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY,
  ];

  static final $core.Map<$core.int, EventCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EventCategory? valueOf($core.int value) => _byValue[value];

  const EventCategory._($core.int v, $core.String n) : super(v, n);
}

