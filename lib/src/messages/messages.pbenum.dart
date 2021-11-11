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
  static const CommandCategory OPEN = CommandCategory._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'OPEN');
  static const CommandCategory CLOSE = CommandCategory._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'CLOSE');
  static const CommandCategory TORCH = CommandCategory._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'TORCH');
  static const CommandCategory ZOOM = CommandCategory._(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ZOOM');
  static const CommandCategory CLOSE_IMAGE_PROXY = CommandCategory._(
      4,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'CLOSE_IMAGE_PROXY');

  static const $core.List<CommandCategory> values = <CommandCategory>[
    OPEN,
    CLOSE,
    TORCH,
    ZOOM,
    CLOSE_IMAGE_PROXY,
  ];

  static final $core.Map<$core.int, CommandCategory> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static CommandCategory? valueOf($core.int value) => _byValue[value];

  const CommandCategory._($core.int v, $core.String n) : super(v, n);
}

class EventCategory extends $pb.ProtobufEnum {
  static const EventCategory QUARTER_TURNS_CHANGED = EventCategory._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'QUARTER_TURNS_CHANGED');
  static const EventCategory TORCH_STATE_CHANGED = EventCategory._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'TORCH_STATE_CHANGED');
  static const EventCategory ZOOM_VALUE_CHANGED = EventCategory._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ZOOM_VALUE_CHANGED');
  static const EventCategory IMAGE_PROXY_RECEIVED = EventCategory._(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'IMAGE_PROXY_RECEIVED');

  static const $core.List<EventCategory> values = <EventCategory>[
    QUARTER_TURNS_CHANGED,
    TORCH_STATE_CHANGED,
    ZOOM_VALUE_CHANGED,
    IMAGE_PROXY_RECEIVED,
  ];

  static final $core.Map<$core.int, EventCategory> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static EventCategory? valueOf($core.int value) => _byValue[value];

  const EventCategory._($core.int v, $core.String n) : super(v, n);
}

class CameraFacing extends $pb.ProtobufEnum {
  static const CameraFacing BACK = CameraFacing._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'BACK');
  static const CameraFacing FRONT = CameraFacing._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'FRONT');

  static const $core.List<CameraFacing> values = <CameraFacing>[
    BACK,
    FRONT,
  ];

  static final $core.Map<$core.int, CameraFacing> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static CameraFacing? valueOf($core.int value) => _byValue[value];

  const CameraFacing._($core.int v, $core.String n) : super(v, n);
}
