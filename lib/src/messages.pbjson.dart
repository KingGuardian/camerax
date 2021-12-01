///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use methodCategoryDescriptor instead')
const MethodCategory$json = const {
  '1': 'MethodCategory',
  '2': const [
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_OPEN', '2': 0},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_CLOSE', '2': 1},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH', '2': 2},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM', '2': 3},
    const {'1': 'COMMAND_CATEGORY_IMAGE_PROXY_CLOSE', '2': 4},
  ],
};

/// Descriptor for `MethodCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List methodCategoryDescriptor = $convert.base64Decode('Cg5NZXRob2RDYXRlZ29yeRIrCidDT01NQU5EX0NBVEVHT1JZX0NBTUVSQV9DT05UUk9MTEVSX09QRU4QABIsCihDT01NQU5EX0NBVEVHT1JZX0NBTUVSQV9DT05UUk9MTEVSX0NMT1NFEAESLAooQ09NTUFORF9DQVRFR09SWV9DQU1FUkFfQ09OVFJPTExFUl9UT1JDSBACEisKJ0NPTU1BTkRfQ0FURUdPUllfQ0FNRVJBX0NPTlRST0xMRVJfWk9PTRADEiYKIkNPTU1BTkRfQ0FURUdPUllfSU1BR0VfUFJPWFlfQ0xPU0UQBA==');
@$core.Deprecated('Use cameraFacingDescriptor instead')
const CameraFacing$json = const {
  '1': 'CameraFacing',
  '2': const [
    const {'1': 'CAMERA_FACING_BACK', '2': 0},
    const {'1': 'CAMERA_FACING_FRONT', '2': 1},
  ],
};

/// Descriptor for `CameraFacing`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cameraFacingDescriptor = $convert.base64Decode('CgxDYW1lcmFGYWNpbmcSFgoSQ0FNRVJBX0ZBQ0lOR19CQUNLEAASFwoTQ0FNRVJBX0ZBQ0lOR19GUk9OVBAB');
@$core.Deprecated('Use eventCategoryDescriptor instead')
const EventCategory$json = const {
  '1': 'EventCategory',
  '2': const [
    const {'1': 'EVENT_CATEGORY_QUARTER_TURNS', '2': 0},
    const {'1': 'EVENT_CATEGORY_CAMERA_CONTROLLER_TORCH_STATE', '2': 1},
    const {'1': 'EVENT_CATEGORY_CAMERA_CONTROLLER_ZOOM_VALUE', '2': 2},
    const {'1': 'EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXY', '2': 3},
  ],
};

/// Descriptor for `EventCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventCategoryDescriptor = $convert.base64Decode('Cg1FdmVudENhdGVnb3J5EiAKHEVWRU5UX0NBVEVHT1JZX1FVQVJURVJfVFVSTlMQABIwCixFVkVOVF9DQVRFR09SWV9DQU1FUkFfQ09OVFJPTExFUl9UT1JDSF9TVEFURRABEi8KK0VWRU5UX0NBVEVHT1JZX0NBTUVSQV9DT05UUk9MTEVSX1pPT01fVkFMVUUQAhIwCixFVkVOVF9DQVRFR09SWV9DQU1FUkFfQ09OVFJPTExFUl9JTUFHRV9QUk9YWRAD');
@$core.Deprecated('Use methodArgumentsDescriptor instead')
const MethodArguments$json = const {
  '1': 'MethodArguments',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.messages.MethodCategory', '10': 'category'},
    const {'1': 'selector', '3': 2, '4': 1, '5': 11, '6': '.messages.CameraSelector', '10': 'selector'},
    const {'1': 'uuid', '3': 3, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'torch_state', '3': 4, '4': 1, '5': 8, '10': 'torchState'},
    const {'1': 'zoom_value', '3': 5, '4': 1, '5': 1, '10': 'zoomValue'},
  ],
};

/// Descriptor for `MethodArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List methodArgumentsDescriptor = $convert.base64Decode('Cg9NZXRob2RBcmd1bWVudHMSNAoIY2F0ZWdvcnkYASABKA4yGC5tZXNzYWdlcy5NZXRob2RDYXRlZ29yeVIIY2F0ZWdvcnkSNAoIc2VsZWN0b3IYAiABKAsyGC5tZXNzYWdlcy5DYW1lcmFTZWxlY3RvclIIc2VsZWN0b3ISEgoEdXVpZBgDIAEoCVIEdXVpZBIfCgt0b3JjaF9zdGF0ZRgEIAEoCFIKdG9yY2hTdGF0ZRIdCgp6b29tX3ZhbHVlGAUgASgBUgl6b29tVmFsdWU=');
@$core.Deprecated('Use cameraSelectorDescriptor instead')
const CameraSelector$json = const {
  '1': 'CameraSelector',
  '2': const [
    const {'1': 'facing', '3': 1, '4': 1, '5': 14, '6': '.messages.CameraFacing', '10': 'facing'},
  ],
};

/// Descriptor for `CameraSelector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraSelectorDescriptor = $convert.base64Decode('Cg5DYW1lcmFTZWxlY3RvchIuCgZmYWNpbmcYASABKA4yFi5tZXNzYWdlcy5DYW1lcmFGYWNpbmdSBmZhY2luZw==');
@$core.Deprecated('Use cameraValueDescriptor instead')
const CameraValue$json = const {
  '1': 'CameraValue',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'texture_value', '3': 2, '4': 1, '5': 11, '6': '.messages.TextureValue', '10': 'textureValue'},
    const {'1': 'torch_value', '3': 3, '4': 1, '5': 11, '6': '.messages.TorchValue', '10': 'torchValue'},
    const {'1': 'zoom_value', '3': 4, '4': 1, '5': 11, '6': '.messages.ZoomValue', '10': 'zoomValue'},
  ],
};

/// Descriptor for `CameraValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraValueDescriptor = $convert.base64Decode('CgtDYW1lcmFWYWx1ZRISCgR1dWlkGAEgASgJUgR1dWlkEjsKDXRleHR1cmVfdmFsdWUYAiABKAsyFi5tZXNzYWdlcy5UZXh0dXJlVmFsdWVSDHRleHR1cmVWYWx1ZRI1Cgt0b3JjaF92YWx1ZRgDIAEoCzIULm1lc3NhZ2VzLlRvcmNoVmFsdWVSCnRvcmNoVmFsdWUSMgoKem9vbV92YWx1ZRgEIAEoCzITLm1lc3NhZ2VzLlpvb21WYWx1ZVIJem9vbVZhbHVl');
@$core.Deprecated('Use textureValueDescriptor instead')
const TextureValue$json = const {
  '1': 'TextureValue',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'width', '3': 2, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'quarter_turns', '3': 4, '4': 1, '5': 5, '10': 'quarterTurns'},
  ],
};

/// Descriptor for `TextureValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textureValueDescriptor = $convert.base64Decode('CgxUZXh0dXJlVmFsdWUSDgoCaWQYASABKAVSAmlkEhQKBXdpZHRoGAIgASgFUgV3aWR0aBIWCgZoZWlnaHQYAyABKAVSBmhlaWdodBIjCg1xdWFydGVyX3R1cm5zGAQgASgFUgxxdWFydGVyVHVybnM=');
@$core.Deprecated('Use torchValueDescriptor instead')
const TorchValue$json = const {
  '1': 'TorchValue',
  '2': const [
    const {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    const {'1': 'state', '3': 2, '4': 1, '5': 8, '10': 'state'},
  ],
};

/// Descriptor for `TorchValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List torchValueDescriptor = $convert.base64Decode('CgpUb3JjaFZhbHVlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYXZhaWxhYmxlEhQKBXN0YXRlGAIgASgIUgVzdGF0ZQ==');
@$core.Deprecated('Use zoomValueDescriptor instead')
const ZoomValue$json = const {
  '1': 'ZoomValue',
  '2': const [
    const {'1': 'minimum', '3': 1, '4': 1, '5': 1, '10': 'minimum'},
    const {'1': 'maximum', '3': 2, '4': 1, '5': 1, '10': 'maximum'},
    const {'1': 'value', '3': 3, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `ZoomValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zoomValueDescriptor = $convert.base64Decode('Cglab29tVmFsdWUSGAoHbWluaW11bRgBIAEoAVIHbWluaW11bRIYCgdtYXhpbXVtGAIgASgBUgdtYXhpbXVtEhQKBXZhbHVlGAMgASgBUgV2YWx1ZQ==');
@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.messages.EventCategory', '10': 'category'},
    const {'1': 'quarter_turns', '3': 2, '4': 1, '5': 5, '10': 'quarterTurns'},
    const {'1': 'uuid', '3': 3, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'torch_state', '3': 4, '4': 1, '5': 8, '10': 'torchState'},
    const {'1': 'zoom_value', '3': 5, '4': 1, '5': 1, '10': 'zoomValue'},
    const {'1': 'image_proxy', '3': 6, '4': 1, '5': 11, '6': '.messages.ImageProxy', '10': 'imageProxy'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode('CgVFdmVudBIzCghjYXRlZ29yeRgBIAEoDjIXLm1lc3NhZ2VzLkV2ZW50Q2F0ZWdvcnlSCGNhdGVnb3J5EiMKDXF1YXJ0ZXJfdHVybnMYAiABKAVSDHF1YXJ0ZXJUdXJucxISCgR1dWlkGAMgASgJUgR1dWlkEh8KC3RvcmNoX3N0YXRlGAQgASgIUgp0b3JjaFN0YXRlEh0KCnpvb21fdmFsdWUYBSABKAFSCXpvb21WYWx1ZRI1CgtpbWFnZV9wcm94eRgGIAEoCzIULm1lc3NhZ2VzLkltYWdlUHJveHlSCmltYWdlUHJveHk=');
@$core.Deprecated('Use imageProxyDescriptor instead')
const ImageProxy$json = const {
  '1': 'ImageProxy',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    const {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `ImageProxy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageProxyDescriptor = $convert.base64Decode('CgpJbWFnZVByb3h5EhIKBHV1aWQYASABKAlSBHV1aWQSEgoEZGF0YRgCIAEoDFIEZGF0YRIUCgV3aWR0aBgDIAEoBVIFd2lkdGgSFgoGaGVpZ2h0GAQgASgFUgZoZWlnaHQ=');
