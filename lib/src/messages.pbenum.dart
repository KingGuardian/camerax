///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CommandCategory extends $pb.ProtobufEnum {
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_CREATE = CommandCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_CREATE');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN = CommandCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE = CommandCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH = CommandCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM = CommandCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY = CommandCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY = CommandCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY');
  static const CommandCategory COMMAND_CATEGORY_CAMERA_CONTROLLER_DISPOSE = CommandCategory._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_CAMERA_CONTROLLER_DISPOSE');
  static const CommandCategory COMMAND_CATEGORY_IMAGE_PROXY_CLOSE = CommandCategory._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMMAND_CATEGORY_IMAGE_PROXY_CLOSE');

  static const $core.List<CommandCategory> values = <CommandCategory> [
    COMMAND_CATEGORY_CAMERA_CONTROLLER_CREATE,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY,
    COMMAND_CATEGORY_CAMERA_CONTROLLER_DISPOSE,
    COMMAND_CATEGORY_IMAGE_PROXY_CLOSE,
  ];

  static final $core.Map<$core.int, CommandCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CommandCategory? valueOf($core.int value) => _byValue[value];

  const CommandCategory._($core.int v, $core.String n) : super(v, n);
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

