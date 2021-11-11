///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pbenum.dart';

export 'messages.pbenum.dart';

enum Command_Stub { openArguments, torchState, zoomValue, notSet }

class Command extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Command_Stub> _Command_StubByTag = {
    3: Command_Stub.openArguments,
    4: Command_Stub.torchState,
    5: Command_Stub.zoomValue,
    0: Command_Stub.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Command',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..e<CommandCategory>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'category',
        $pb.PbFieldType.OE,
        defaultOrMaker: CommandCategory.OPEN,
        valueOf: CommandCategory.valueOf,
        enumValues: CommandCategory.values)
    ..aOM<OpenArguments>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'openArguments',
        subBuilder: OpenArguments.create)
    ..aOB(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'torchState')
    ..a<$core.double>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'zoomValue',
        $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  Command._() : super();
  factory Command({
    $core.String? key,
    CommandCategory? category,
    OpenArguments? openArguments,
    $core.bool? torchState,
    $core.double? zoomValue,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (category != null) {
      _result.category = category;
    }
    if (openArguments != null) {
      _result.openArguments = openArguments;
    }
    if (torchState != null) {
      _result.torchState = torchState;
    }
    if (zoomValue != null) {
      _result.zoomValue = zoomValue;
    }
    return _result;
  }
  factory Command.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Command.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Command clone() => Command()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Command copyWith(void Function(Command) updates) =>
      super.copyWith((message) => updates(message as Command))
          as Command; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Command create() => Command._();
  Command createEmptyInstance() => create();
  static $pb.PbList<Command> createRepeated() => $pb.PbList<Command>();
  @$core.pragma('dart2js:noInline')
  static Command getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Command>(create);
  static Command? _defaultInstance;

  Command_Stub whichStub() => _Command_StubByTag[$_whichOneof(0)]!;
  void clearStub() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  CommandCategory get category => $_getN(1);
  @$pb.TagNumber(2)
  set category(CommandCategory v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  OpenArguments get openArguments => $_getN(2);
  @$pb.TagNumber(3)
  set openArguments(OpenArguments v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOpenArguments() => $_has(2);
  @$pb.TagNumber(3)
  void clearOpenArguments() => clearField(3);
  @$pb.TagNumber(3)
  OpenArguments ensureOpenArguments() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get torchState => $_getBF(3);
  @$pb.TagNumber(4)
  set torchState($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTorchState() => $_has(3);
  @$pb.TagNumber(4)
  void clearTorchState() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get zoomValue => $_getN(4);
  @$pb.TagNumber(5)
  set zoomValue($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasZoomValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearZoomValue() => clearField(5);
}

enum Event_Stub { quarterTurns, torchState, zoomValue, image, notSet }

class Event extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Event_Stub> _Event_StubByTag = {
    3: Event_Stub.quarterTurns,
    4: Event_Stub.torchState,
    5: Event_Stub.zoomValue,
    6: Event_Stub.image,
    0: Event_Stub.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Event',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..e<EventCategory>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'category',
        $pb.PbFieldType.OE,
        defaultOrMaker: EventCategory.QUARTER_TURNS_CHANGED,
        valueOf: EventCategory.valueOf,
        enumValues: EventCategory.values)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'quarterTurns',
        $pb.PbFieldType.O3,
        protoName: 'quarterTurns')
    ..aOB(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'torchState')
    ..a<$core.double>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'zoomValue',
        $pb.PbFieldType.OD)
    ..aOM<ImageProxy>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'image',
        subBuilder: ImageProxy.create)
    ..hasRequiredFields = false;

  Event._() : super();
  factory Event({
    $core.String? key,
    EventCategory? category,
    $core.int? quarterTurns,
    $core.bool? torchState,
    $core.double? zoomValue,
    ImageProxy? image,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (category != null) {
      _result.category = category;
    }
    if (quarterTurns != null) {
      _result.quarterTurns = quarterTurns;
    }
    if (torchState != null) {
      _result.torchState = torchState;
    }
    if (zoomValue != null) {
      _result.zoomValue = zoomValue;
    }
    if (image != null) {
      _result.image = image;
    }
    return _result;
  }
  factory Event.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Event copyWith(void Function(Event) updates) =>
      super.copyWith((message) => updates(message as Event))
          as Event; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  Event_Stub whichStub() => _Event_StubByTag[$_whichOneof(0)]!;
  void clearStub() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  EventCategory get category => $_getN(1);
  @$pb.TagNumber(2)
  set category(EventCategory v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get quarterTurns => $_getIZ(2);
  @$pb.TagNumber(3)
  set quarterTurns($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasQuarterTurns() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuarterTurns() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get torchState => $_getBF(3);
  @$pb.TagNumber(4)
  set torchState($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTorchState() => $_has(3);
  @$pb.TagNumber(4)
  void clearTorchState() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get zoomValue => $_getN(4);
  @$pb.TagNumber(5)
  set zoomValue($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasZoomValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearZoomValue() => clearField(5);

  @$pb.TagNumber(6)
  ImageProxy get image => $_getN(5);
  @$pb.TagNumber(6)
  set image(ImageProxy v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearImage() => clearField(6);
  @$pb.TagNumber(6)
  ImageProxy ensureImage() => $_ensure(5);
}

class OpenArguments extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'OpenArguments',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..aOM<CameraSelector>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'selector',
        subBuilder: CameraSelector.create)
    ..hasRequiredFields = false;

  OpenArguments._() : super();
  factory OpenArguments({
    CameraSelector? selector,
  }) {
    final _result = create();
    if (selector != null) {
      _result.selector = selector;
    }
    return _result;
  }
  factory OpenArguments.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OpenArguments.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OpenArguments clone() => OpenArguments()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OpenArguments copyWith(void Function(OpenArguments) updates) =>
      super.copyWith((message) => updates(message as OpenArguments))
          as OpenArguments; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OpenArguments create() => OpenArguments._();
  OpenArguments createEmptyInstance() => create();
  static $pb.PbList<OpenArguments> createRepeated() =>
      $pb.PbList<OpenArguments>();
  @$core.pragma('dart2js:noInline')
  static OpenArguments getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenArguments>(create);
  static OpenArguments? _defaultInstance;

  @$pb.TagNumber(1)
  CameraSelector get selector => $_getN(0);
  @$pb.TagNumber(1)
  set selector(CameraSelector v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);
  @$pb.TagNumber(1)
  CameraSelector ensureSelector() => $_ensure(0);
}

class CameraSelector extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CameraSelector',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..e<CameraFacing>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'facing',
        $pb.PbFieldType.OE,
        defaultOrMaker: CameraFacing.BACK,
        valueOf: CameraFacing.valueOf,
        enumValues: CameraFacing.values)
    ..hasRequiredFields = false;

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
  factory CameraSelector.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CameraSelector.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CameraSelector clone() => CameraSelector()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CameraSelector copyWith(void Function(CameraSelector) updates) =>
      super.copyWith((message) => updates(message as CameraSelector))
          as CameraSelector; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraSelector create() => CameraSelector._();
  CameraSelector createEmptyInstance() => create();
  static $pb.PbList<CameraSelector> createRepeated() =>
      $pb.PbList<CameraSelector>();
  @$core.pragma('dart2js:noInline')
  static CameraSelector getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CameraSelector>(create);
  static CameraSelector? _defaultInstance;

  @$pb.TagNumber(1)
  CameraFacing get facing => $_getN(0);
  @$pb.TagNumber(1)
  set facing(CameraFacing v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFacing() => $_has(0);
  @$pb.TagNumber(1)
  void clearFacing() => clearField(1);
}

class CameraValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CameraValue',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..aOM<TextureValue>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'textureValue',
        subBuilder: TextureValue.create)
    ..aOM<TorchValue>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'torchValue',
        subBuilder: TorchValue.create)
    ..aOM<ZoomValue>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'zoomValue',
        subBuilder: ZoomValue.create)
    ..hasRequiredFields = false;

  CameraValue._() : super();
  factory CameraValue({
    $core.String? key,
    TextureValue? textureValue,
    TorchValue? torchValue,
    ZoomValue? zoomValue,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (textureValue != null) {
      _result.textureValue = textureValue;
    }
    if (torchValue != null) {
      _result.torchValue = torchValue;
    }
    if (zoomValue != null) {
      _result.zoomValue = zoomValue;
    }
    return _result;
  }
  factory CameraValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CameraValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CameraValue clone() => CameraValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CameraValue copyWith(void Function(CameraValue) updates) =>
      super.copyWith((message) => updates(message as CameraValue))
          as CameraValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraValue create() => CameraValue._();
  CameraValue createEmptyInstance() => create();
  static $pb.PbList<CameraValue> createRepeated() => $pb.PbList<CameraValue>();
  @$core.pragma('dart2js:noInline')
  static CameraValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CameraValue>(create);
  static CameraValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  TextureValue get textureValue => $_getN(1);
  @$pb.TagNumber(2)
  set textureValue(TextureValue v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTextureValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTextureValue() => clearField(2);
  @$pb.TagNumber(2)
  TextureValue ensureTextureValue() => $_ensure(1);

  @$pb.TagNumber(3)
  TorchValue get torchValue => $_getN(2);
  @$pb.TagNumber(3)
  set torchValue(TorchValue v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTorchValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTorchValue() => clearField(3);
  @$pb.TagNumber(3)
  TorchValue ensureTorchValue() => $_ensure(2);

  @$pb.TagNumber(4)
  ZoomValue get zoomValue => $_getN(3);
  @$pb.TagNumber(4)
  set zoomValue(ZoomValue v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasZoomValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearZoomValue() => clearField(4);
  @$pb.TagNumber(4)
  ZoomValue ensureZoomValue() => $_ensure(3);
}

class TextureValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TextureValue',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'width',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'height',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'quarterTurns',
        $pb.PbFieldType.O3,
        protoName: 'quarterTurns')
    ..hasRequiredFields = false;

  TextureValue._() : super();
  factory TextureValue({
    $core.int? id,
    $core.int? width,
    $core.int? height,
    $core.int? quarterTurns,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (quarterTurns != null) {
      _result.quarterTurns = quarterTurns;
    }
    return _result;
  }
  factory TextureValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TextureValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TextureValue clone() => TextureValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TextureValue copyWith(void Function(TextureValue) updates) =>
      super.copyWith((message) => updates(message as TextureValue))
          as TextureValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextureValue create() => TextureValue._();
  TextureValue createEmptyInstance() => create();
  static $pb.PbList<TextureValue> createRepeated() =>
      $pb.PbList<TextureValue>();
  @$core.pragma('dart2js:noInline')
  static TextureValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TextureValue>(create);
  static TextureValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get width => $_getIZ(1);
  @$pb.TagNumber(2)
  set width($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get height => $_getIZ(2);
  @$pb.TagNumber(3)
  set height($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get quarterTurns => $_getIZ(3);
  @$pb.TagNumber(4)
  set quarterTurns($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasQuarterTurns() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuarterTurns() => clearField(4);
}

class TorchValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TorchValue',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..aOB(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'available')
    ..aOB(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'state')
    ..hasRequiredFields = false;

  TorchValue._() : super();
  factory TorchValue({
    $core.bool? available,
    $core.bool? state,
  }) {
    final _result = create();
    if (available != null) {
      _result.available = available;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory TorchValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TorchValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TorchValue clone() => TorchValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TorchValue copyWith(void Function(TorchValue) updates) =>
      super.copyWith((message) => updates(message as TorchValue))
          as TorchValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TorchValue create() => TorchValue._();
  TorchValue createEmptyInstance() => create();
  static $pb.PbList<TorchValue> createRepeated() => $pb.PbList<TorchValue>();
  @$core.pragma('dart2js:noInline')
  static TorchValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TorchValue>(create);
  static TorchValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

class ZoomValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ZoomValue',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'minimum',
        $pb.PbFieldType.OD)
    ..a<$core.double>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'maximum',
        $pb.PbFieldType.OD)
    ..a<$core.double>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'value',
        $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  ZoomValue._() : super();
  factory ZoomValue({
    $core.double? minimum,
    $core.double? maximum,
    $core.double? value,
  }) {
    final _result = create();
    if (minimum != null) {
      _result.minimum = minimum;
    }
    if (maximum != null) {
      _result.maximum = maximum;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ZoomValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ZoomValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ZoomValue clone() => ZoomValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ZoomValue copyWith(void Function(ZoomValue) updates) =>
      super.copyWith((message) => updates(message as ZoomValue))
          as ZoomValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ZoomValue create() => ZoomValue._();
  ZoomValue createEmptyInstance() => create();
  static $pb.PbList<ZoomValue> createRepeated() => $pb.PbList<ZoomValue>();
  @$core.pragma('dart2js:noInline')
  static ZoomValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ZoomValue>(create);
  static ZoomValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get minimum => $_getN(0);
  @$pb.TagNumber(1)
  set minimum($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMinimum() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinimum() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get maximum => $_getN(1);
  @$pb.TagNumber(2)
  set maximum($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMaximum() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaximum() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get value => $_getN(2);
  @$pb.TagNumber(3)
  set value($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class ImageProxy extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ImageProxy',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'messages'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..a<$core.List<$core.int>>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.OY)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'width',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'height',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ImageProxy._() : super();
  factory ImageProxy({
    $core.String? key,
    $core.List<$core.int>? data,
    $core.int? width,
    $core.int? height,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (data != null) {
      _result.data = data;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory ImageProxy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImageProxy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImageProxy clone() => ImageProxy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImageProxy copyWith(void Function(ImageProxy) updates) =>
      super.copyWith((message) => updates(message as ImageProxy))
          as ImageProxy; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageProxy create() => ImageProxy._();
  ImageProxy createEmptyInstance() => create();
  static $pb.PbList<ImageProxy> createRepeated() => $pb.PbList<ImageProxy>();
  @$core.pragma('dart2js:noInline')
  static ImageProxy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImageProxy>(create);
  static ImageProxy? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get width => $_getIZ(2);
  @$pb.TagNumber(3)
  set width($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get height => $_getIZ(3);
  @$pb.TagNumber(4)
  set height($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);
}
