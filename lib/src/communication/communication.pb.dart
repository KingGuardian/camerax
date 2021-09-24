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
  textureInfo, 
  torchState, 
  analysis, 
  notSet
}

class Message extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Message_Stub> _Message_StubByTag = {
    3 : Message_Stub.bindArgs,
    4 : Message_Stub.textureInfo,
    5 : Message_Stub.torchState,
    6 : Message_Stub.analysis,
    0 : Message_Stub.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.O3)
    ..e<MessageCategory>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: MessageCategory.BIND, valueOf: MessageCategory.valueOf, enumValues: MessageCategory.values)
    ..aOM<BindArgs>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bindArgs', subBuilder: BindArgs.create)
    ..aOM<TextureInfo>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textureInfo', subBuilder: TextureInfo.create)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'torchState')
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'analysis', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message({
    $core.int? key,
    MessageCategory? category,
    BindArgs? bindArgs,
    TextureInfo? textureInfo,
    $core.bool? torchState,
    $core.List<$core.int>? analysis,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (category != null) {
      _result.category = category;
    }
    if (bindArgs != null) {
      _result.bindArgs = bindArgs;
    }
    if (textureInfo != null) {
      _result.textureInfo = textureInfo;
    }
    if (torchState != null) {
      _result.torchState = torchState;
    }
    if (analysis != null) {
      _result.analysis = analysis;
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
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  MessageCategory get category => $_getN(1);
  @$pb.TagNumber(2)
  set category(MessageCategory v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  BindArgs get bindArgs => $_getN(2);
  @$pb.TagNumber(3)
  set bindArgs(BindArgs v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBindArgs() => $_has(2);
  @$pb.TagNumber(3)
  void clearBindArgs() => clearField(3);
  @$pb.TagNumber(3)
  BindArgs ensureBindArgs() => $_ensure(2);

  @$pb.TagNumber(4)
  TextureInfo get textureInfo => $_getN(3);
  @$pb.TagNumber(4)
  set textureInfo(TextureInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTextureInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearTextureInfo() => clearField(4);
  @$pb.TagNumber(4)
  TextureInfo ensureTextureInfo() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get torchState => $_getBF(4);
  @$pb.TagNumber(5)
  set torchState($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTorchState() => $_has(4);
  @$pb.TagNumber(5)
  void clearTorchState() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get analysis => $_getN(5);
  @$pb.TagNumber(6)
  set analysis($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAnalysis() => $_has(5);
  @$pb.TagNumber(6)
  void clearAnalysis() => clearField(6);
}

class BindArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BindArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..aOM<CameraSelector>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selector', subBuilder: CameraSelector.create)
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

  @$pb.TagNumber(2)
  CameraSelector get selector => $_getN(0);
  @$pb.TagNumber(2)
  set selector(CameraSelector v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(2)
  void clearSelector() => clearField(2);
  @$pb.TagNumber(2)
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

class CameraInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTorch')
    ..hasRequiredFields = false
  ;

  CameraInfo._() : super();
  factory CameraInfo({
    $core.bool? hasTorch,
  }) {
    final _result = create();
    if (hasTorch != null) {
      _result.hasTorch = hasTorch;
    }
    return _result;
  }
  factory CameraInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraInfo clone() => CameraInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraInfo copyWith(void Function(CameraInfo) updates) => super.copyWith((message) => updates(message as CameraInfo)) as CameraInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraInfo create() => CameraInfo._();
  CameraInfo createEmptyInstance() => create();
  static $pb.PbList<CameraInfo> createRepeated() => $pb.PbList<CameraInfo>();
  @$core.pragma('dart2js:noInline')
  static CameraInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraInfo>(create);
  static CameraInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasTorch => $_getBF(0);
  @$pb.TagNumber(1)
  set hasTorch($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHasTorch() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasTorch() => clearField(1);
}

class TextureInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TextureInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOM<TextureSize>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size', subBuilder: TextureSize.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quarterTurns', $pb.PbFieldType.O3, protoName: 'quarterTurns')
    ..hasRequiredFields = false
  ;

  TextureInfo._() : super();
  factory TextureInfo({
    $core.int? id,
    TextureSize? size,
    $core.int? quarterTurns,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (size != null) {
      _result.size = size;
    }
    if (quarterTurns != null) {
      _result.quarterTurns = quarterTurns;
    }
    return _result;
  }
  factory TextureInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextureInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TextureInfo clone() => TextureInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TextureInfo copyWith(void Function(TextureInfo) updates) => super.copyWith((message) => updates(message as TextureInfo)) as TextureInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextureInfo create() => TextureInfo._();
  TextureInfo createEmptyInstance() => create();
  static $pb.PbList<TextureInfo> createRepeated() => $pb.PbList<TextureInfo>();
  @$core.pragma('dart2js:noInline')
  static TextureInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextureInfo>(create);
  static TextureInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  TextureSize get size => $_getN(1);
  @$pb.TagNumber(2)
  set size(TextureSize v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => clearField(2);
  @$pb.TagNumber(2)
  TextureSize ensureSize() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get quarterTurns => $_getIZ(2);
  @$pb.TagNumber(3)
  set quarterTurns($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuarterTurns() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuarterTurns() => clearField(3);
}

class TextureSize extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TextureSize', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'communication'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TextureSize._() : super();
  factory TextureSize({
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
  factory TextureSize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextureSize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TextureSize clone() => TextureSize()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TextureSize copyWith(void Function(TextureSize) updates) => super.copyWith((message) => updates(message as TextureSize)) as TextureSize; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextureSize create() => TextureSize._();
  TextureSize createEmptyInstance() => create();
  static $pb.PbList<TextureSize> createRepeated() => $pb.PbList<TextureSize>();
  @$core.pragma('dart2js:noInline')
  static TextureSize getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextureSize>(create);
  static TextureSize? _defaultInstance;

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

