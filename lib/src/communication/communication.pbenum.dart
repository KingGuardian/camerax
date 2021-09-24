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
  static const MessageCategory BIND = MessageCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BIND');
  static const MessageCategory UNBIND = MessageCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNBIND');
  static const MessageCategory TEXTURE_INFO = MessageCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXTURE_INFO');
  static const MessageCategory TEXTURE_INFO_EVENT = MessageCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXTURE_INFO_EVENT');
  static const MessageCategory TORCH = MessageCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TORCH');
  static const MessageCategory TORCH_EVENT = MessageCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TORCH_EVENT');
  static const MessageCategory ANALYSIS_EVENT = MessageCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ANALYSIS_EVENT');

  static const $core.List<MessageCategory> values = <MessageCategory> [
    BIND,
    UNBIND,
    TEXTURE_INFO,
    TEXTURE_INFO_EVENT,
    TORCH,
    TORCH_EVENT,
    ANALYSIS_EVENT,
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

