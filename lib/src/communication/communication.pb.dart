///
//  Generated code. Do not modify.
//  source: communication.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'communication.pbenum.dart';

export 'communication.pbenum.dart';

enum Message_Stub {
  bindArgs, 
  unbindArgs, 
  torchArgs, 
  rotation, 
  notSet
}

class Message extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Message_Stub> _Message_StubByTag = {
    2 : Message_Stub.bindArgs,
    3 : Message_Stub.unbindArgs,
    4 : Message_Stub.torchArgs,
    5 : Message_Stub.rotation,
    0 : Message_Stub.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5])
    ..e<MessageCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: MessageCategory.CAMERA_CONTROLLER_BIND, valueOf: MessageCategory.valueOf, enumValues: MessageCategory.values)
    ..aOM<BindArgs>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bindArgs', protoName: 'bindArgs', subBuilder: BindArgs.create)
    ..aOM<UnbindArgs>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unbindArgs', protoName: 'unbindArgs', subBuilder: UnbindArgs.create)
    ..aOM<TorchArgs>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'torchArgs', protoName: 'torchArgs', subBuilder: TorchArgs.create)
    ..e<DisplayRotation>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rotation', $pb.PbFieldType.OE, defaultOrMaker: DisplayRotation.ROTATION_0, valueOf: DisplayRotation.valueOf, enumValues: DisplayRotation.values)
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message({
    MessageCategory? category,
    BindArgs? bindArgs,
    UnbindArgs? unbindArgs,
    TorchArgs? torchArgs,
    DisplayRotation? rotation,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (bindArgs != null) {
      _result.bindArgs = bindArgs;
    }
    if (unbindArgs != null) {
      _result.unbindArgs = unbindArgs;
    }
    if (torchArgs != null) {
      _result.torchArgs = torchArgs;
    }
    if (rotation != null) {
      _result.rotation = rotation;
    }
    return _result;
  }
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  Message_Stub whichStub() => _Message_StubByTag[$_whichOneof(0)]!;
  void clearStub() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  MessageCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(MessageCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  BindArgs get bindArgs => $_getN(1);
  @$pb.TagNumber(2)
  set bindArgs(BindArgs v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBindArgs() => $_has(1);
  @$pb.TagNumber(2)
  void clearBindArgs() => clearField(2);
  @$pb.TagNumber(2)
  BindArgs ensureBindArgs() => $_ensure(1);

  @$pb.TagNumber(3)
  UnbindArgs get unbindArgs => $_getN(2);
  @$pb.TagNumber(3)
  set unbindArgs(UnbindArgs v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnbindArgs() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnbindArgs() => clearField(3);
  @$pb.TagNumber(3)
  UnbindArgs ensureUnbindArgs() => $_ensure(2);

  @$pb.TagNumber(4)
  TorchArgs get torchArgs => $_getN(3);
  @$pb.TagNumber(4)
  set torchArgs(TorchArgs v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTorchArgs() => $_has(3);
  @$pb.TagNumber(4)
  void clearTorchArgs() => clearField(4);
  @$pb.TagNumber(4)
  TorchArgs ensureTorchArgs() => $_ensure(3);

  @$pb.TagNumber(5)
  DisplayRotation get rotation => $_getN(4);
  @$pb.TagNumber(5)
  set rotation(DisplayRotation v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRotation() => $_has(4);
  @$pb.TagNumber(5)
  void clearRotation() => clearField(5);
}

class BindArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BindArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..aOM<CameraSelector>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selector', subBuilder: CameraSelector.create)
    ..hasRequiredFields = false
  ;

  BindArgs._() : super();
  factory BindArgs({
    CameraSelector? selector,
  }) {
    final _result = create();
    if (selector != null) {
      _result.selector = selector;
    }
    return _result;
  }
  factory BindArgs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BindArgs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BindArgs clone() => BindArgs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BindArgs copyWith(void Function(BindArgs) updates) => super.copyWith((message) => updates(message as BindArgs)) as BindArgs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BindArgs create() => BindArgs._();
  BindArgs createEmptyInstance() => create();
  static $pb.PbList<BindArgs> createRepeated() => $pb.PbList<BindArgs>();
  @$core.pragma('dart2js:noInline')
  static BindArgs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BindArgs>(create);
  static BindArgs? _defaultInstance;

  @$pb.TagNumber(1)
  CameraSelector get selector => $_getN(0);
  @$pb.TagNumber(1)
  set selector(CameraSelector v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);
  @$pb.TagNumber(1)
  CameraSelector ensureSelector() => $_ensure(0);
}

class CameraSelector extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraSelector', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..e<CameraFacing>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'facing', $pb.PbFieldType.OE, defaultOrMaker: CameraFacing.FRONT, valueOf: CameraFacing.valueOf, enumValues: CameraFacing.values)
    ..hasRequiredFields = false
  ;

  CameraSelector._() : super();
  factory CameraSelector({
    CameraFacing? facing,
  }) {
    final _result = create();
    if (facing != null) {
      _result.facing = facing;
    }
    return _result;
  }
  factory CameraSelector.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraSelector.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraSelector clone() => CameraSelector()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraSelector copyWith(void Function(CameraSelector) updates) => super.copyWith((message) => updates(message as CameraSelector)) as CameraSelector; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraSelector create() => CameraSelector._();
  CameraSelector createEmptyInstance() => create();
  static $pb.PbList<CameraSelector> createRepeated() => $pb.PbList<CameraSelector>();
  @$core.pragma('dart2js:noInline')
  static CameraSelector getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraSelector>(create);
  static CameraSelector? _defaultInstance;

  @$pb.TagNumber(1)
  CameraFacing get facing => $_getN(0);
  @$pb.TagNumber(1)
  set facing(CameraFacing v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFacing() => $_has(0);
  @$pb.TagNumber(1)
  void clearFacing() => clearField(1);
}

class CameraBinding extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraBinding', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOM<CameraArgs>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cameraArgs', protoName: 'cameraArgs', subBuilder: CameraArgs.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'torchState', protoName: 'torchState')
    ..hasRequiredFields = false
  ;

  CameraBinding._() : super();
  factory CameraBinding({
    $core.String? key,
    CameraArgs? cameraArgs,
    $core.bool? torchState,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (cameraArgs != null) {
      _result.cameraArgs = cameraArgs;
    }
    if (torchState != null) {
      _result.torchState = torchState;
    }
    return _result;
  }
  factory CameraBinding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraBinding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraBinding clone() => CameraBinding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraBinding copyWith(void Function(CameraBinding) updates) => super.copyWith((message) => updates(message as CameraBinding)) as CameraBinding; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraBinding create() => CameraBinding._();
  CameraBinding createEmptyInstance() => create();
  static $pb.PbList<CameraBinding> createRepeated() => $pb.PbList<CameraBinding>();
  @$core.pragma('dart2js:noInline')
  static CameraBinding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraBinding>(create);
  static CameraBinding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  CameraArgs get cameraArgs => $_getN(1);
  @$pb.TagNumber(2)
  set cameraArgs(CameraArgs v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCameraArgs() => $_has(1);
  @$pb.TagNumber(2)
  void clearCameraArgs() => clearField(2);
  @$pb.TagNumber(2)
  CameraArgs ensureCameraArgs() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get torchState => $_getBF(2);
  @$pb.TagNumber(3)
  set torchState($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTorchState() => $_has(2);
  @$pb.TagNumber(3)
  void clearTorchState() => clearField(3);
}

class UnbindArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnbindArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..hasRequiredFields = false
  ;

  UnbindArgs._() : super();
  factory UnbindArgs({
    $core.String? key,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory UnbindArgs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnbindArgs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnbindArgs clone() => UnbindArgs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnbindArgs copyWith(void Function(UnbindArgs) updates) => super.copyWith((message) => updates(message as UnbindArgs)) as UnbindArgs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnbindArgs create() => UnbindArgs._();
  UnbindArgs createEmptyInstance() => create();
  static $pb.PbList<UnbindArgs> createRepeated() => $pb.PbList<UnbindArgs>();
  @$core.pragma('dart2js:noInline')
  static UnbindArgs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnbindArgs>(create);
  static UnbindArgs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);
}

class TorchArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TorchArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..hasRequiredFields = false
  ;

  TorchArgs._() : super();
  factory TorchArgs({
    $core.String? key,
    $core.bool? state,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory TorchArgs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TorchArgs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TorchArgs clone() => TorchArgs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TorchArgs copyWith(void Function(TorchArgs) updates) => super.copyWith((message) => updates(message as TorchArgs)) as TorchArgs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TorchArgs create() => TorchArgs._();
  TorchArgs createEmptyInstance() => create();
  static $pb.PbList<TorchArgs> createRepeated() => $pb.PbList<TorchArgs>();
  @$core.pragma('dart2js:noInline')
  static TorchArgs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TorchArgs>(create);
  static TorchArgs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

class CameraArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textureId', $pb.PbFieldType.O3, protoName: 'textureId')
    ..aOM<CameraSize>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size', subBuilder: CameraSize.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTorch', protoName: 'hasTorch')
    ..hasRequiredFields = false
  ;

  CameraArgs._() : super();
  factory CameraArgs({
    $core.int? textureId,
    CameraSize? size,
    $core.bool? hasTorch,
  }) {
    final _result = create();
    if (textureId != null) {
      _result.textureId = textureId;
    }
    if (size != null) {
      _result.size = size;
    }
    if (hasTorch != null) {
      _result.hasTorch = hasTorch;
    }
    return _result;
  }
  factory CameraArgs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraArgs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraArgs clone() => CameraArgs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraArgs copyWith(void Function(CameraArgs) updates) => super.copyWith((message) => updates(message as CameraArgs)) as CameraArgs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraArgs create() => CameraArgs._();
  CameraArgs createEmptyInstance() => create();
  static $pb.PbList<CameraArgs> createRepeated() => $pb.PbList<CameraArgs>();
  @$core.pragma('dart2js:noInline')
  static CameraArgs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraArgs>(create);
  static CameraArgs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get textureId => $_getIZ(0);
  @$pb.TagNumber(1)
  set textureId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTextureId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTextureId() => clearField(1);

  @$pb.TagNumber(2)
  CameraSize get size => $_getN(1);
  @$pb.TagNumber(2)
  set size(CameraSize v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => clearField(2);
  @$pb.TagNumber(2)
  CameraSize ensureSize() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get hasTorch => $_getBF(2);
  @$pb.TagNumber(3)
  set hasTorch($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHasTorch() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasTorch() => clearField(3);
}

class CameraSize extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraSize', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CameraSize._() : super();
  factory CameraSize({
    $core.int? width,
    $core.int? height,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory CameraSize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraSize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraSize clone() => CameraSize()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraSize copyWith(void Function(CameraSize) updates) => super.copyWith((message) => updates(message as CameraSize)) as CameraSize; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraSize create() => CameraSize._();
  CameraSize createEmptyInstance() => create();
  static $pb.PbList<CameraSize> createRepeated() => $pb.PbList<CameraSize>();
  @$core.pragma('dart2js:noInline')
  static CameraSize getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraSize>(create);
  static CameraSize? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get width => $_getIZ(0);
  @$pb.TagNumber(1)
  set width($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);
}

