///
//  Generated code. Do not modify.
//  source: communication.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use messageCategoryDescriptor instead')
const MessageCategory$json = const {
  '1': 'MessageCategory',
  '2': const [
    const {'1': 'CAMERA_CONTROLLER_BIND', '2': 0},
    const {'1': 'CAMERA_CONTROLLER_UNBIND', '2': 1},
    const {'1': 'CAMERA_CONTROLLER_TORCH', '2': 2},
    const {'1': 'CAMERA_ARGS_CHANGED', '2': 3},
    const {'1': 'TORCH_STATE_CHANGED', '2': 4},
    const {'1': 'DEVICE_GET_ROTATION', '2': 5},
    const {'1': 'DEVICE_ROTATION_CHANGED', '2': 6},
  ],
};

/// Descriptor for `MessageCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageCategoryDescriptor = $convert.base64Decode('Cg9NZXNzYWdlQ2F0ZWdvcnkSGgoWQ0FNRVJBX0NPTlRST0xMRVJfQklORBAAEhwKGENBTUVSQV9DT05UUk9MTEVSX1VOQklORBABEhsKF0NBTUVSQV9DT05UUk9MTEVSX1RPUkNIEAISFwoTQ0FNRVJBX0FSR1NfQ0hBTkdFRBADEhcKE1RPUkNIX1NUQVRFX0NIQU5HRUQQBBIXChNERVZJQ0VfR0VUX1JPVEFUSU9OEAUSGwoXREVWSUNFX1JPVEFUSU9OX0NIQU5HRUQQBg==');
@$core.Deprecated('Use cameraFacingDescriptor instead')
const CameraFacing$json = const {
  '1': 'CameraFacing',
  '2': const [
    const {'1': 'FRONT', '2': 0},
    const {'1': 'BACK', '2': 1},
  ],
};

/// Descriptor for `CameraFacing`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cameraFacingDescriptor = $convert.base64Decode('CgxDYW1lcmFGYWNpbmcSCQoFRlJPTlQQABIICgRCQUNLEAE=');
@$core.Deprecated('Use displayRotationDescriptor instead')
const DisplayRotation$json = const {
  '1': 'DisplayRotation',
  '2': const [
    const {'1': 'ROTATION_0', '2': 0},
    const {'1': 'ROTATION_90', '2': 1},
    const {'1': 'ROTATION_180', '2': 2},
    const {'1': 'ROTATION_270', '2': 3},
  ],
};

/// Descriptor for `DisplayRotation`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List displayRotationDescriptor = $convert.base64Decode('Cg9EaXNwbGF5Um90YXRpb24SDgoKUk9UQVRJT05fMBAAEg8KC1JPVEFUSU9OXzkwEAESEAoMUk9UQVRJT05fMTgwEAISEAoMUk9UQVRJT05fMjcwEAM=');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.communication.MessageCategory', '10': 'category'},
    const {'1': 'bindArgs', '3': 2, '4': 1, '5': 11, '6': '.communication.BindArgs', '9': 0, '10': 'bindArgs'},
    const {'1': 'unbindArgs', '3': 3, '4': 1, '5': 11, '6': '.communication.UnbindArgs', '9': 0, '10': 'unbindArgs'},
    const {'1': 'torchArgs', '3': 4, '4': 1, '5': 11, '6': '.communication.TorchArgs', '9': 0, '10': 'torchArgs'},
    const {'1': 'rotation', '3': 5, '4': 1, '5': 14, '6': '.communication.DisplayRotation', '9': 0, '10': 'rotation'},
  ],
  '8': const [
    const {'1': 'stub'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEjoKCGNhdGVnb3J5GAEgASgOMh4uY29tbXVuaWNhdGlvbi5NZXNzYWdlQ2F0ZWdvcnlSCGNhdGVnb3J5EjUKCGJpbmRBcmdzGAIgASgLMhcuY29tbXVuaWNhdGlvbi5CaW5kQXJnc0gAUghiaW5kQXJncxI7Cgp1bmJpbmRBcmdzGAMgASgLMhkuY29tbXVuaWNhdGlvbi5VbmJpbmRBcmdzSABSCnVuYmluZEFyZ3MSOAoJdG9yY2hBcmdzGAQgASgLMhguY29tbXVuaWNhdGlvbi5Ub3JjaEFyZ3NIAFIJdG9yY2hBcmdzEjwKCHJvdGF0aW9uGAUgASgOMh4uY29tbXVuaWNhdGlvbi5EaXNwbGF5Um90YXRpb25IAFIIcm90YXRpb25CBgoEc3R1Yg==');
@$core.Deprecated('Use bindArgsDescriptor instead')
const BindArgs$json = const {
  '1': 'BindArgs',
  '2': const [
    const {'1': 'selector', '3': 1, '4': 1, '5': 11, '6': '.communication.CameraSelector', '10': 'selector'},
  ],
};

/// Descriptor for `BindArgs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bindArgsDescriptor = $convert.base64Decode('CghCaW5kQXJncxI5CghzZWxlY3RvchgBIAEoCzIdLmNvbW11bmljYXRpb24uQ2FtZXJhU2VsZWN0b3JSCHNlbGVjdG9y');
@$core.Deprecated('Use cameraSelectorDescriptor instead')
const CameraSelector$json = const {
  '1': 'CameraSelector',
  '2': const [
    const {'1': 'facing', '3': 1, '4': 1, '5': 14, '6': '.communication.CameraFacing', '10': 'facing'},
  ],
};

/// Descriptor for `CameraSelector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraSelectorDescriptor = $convert.base64Decode('Cg5DYW1lcmFTZWxlY3RvchIzCgZmYWNpbmcYASABKA4yGy5jb21tdW5pY2F0aW9uLkNhbWVyYUZhY2luZ1IGZmFjaW5n');
@$core.Deprecated('Use cameraBindingDescriptor instead')
const CameraBinding$json = const {
  '1': 'CameraBinding',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'cameraArgs', '3': 2, '4': 1, '5': 11, '6': '.communication.CameraArgs', '10': 'cameraArgs'},
    const {'1': 'torchState', '3': 3, '4': 1, '5': 8, '10': 'torchState'},
  ],
};

/// Descriptor for `CameraBinding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraBindingDescriptor = $convert.base64Decode('Cg1DYW1lcmFCaW5kaW5nEhAKA2tleRgBIAEoCVIDa2V5EjkKCmNhbWVyYUFyZ3MYAiABKAsyGS5jb21tdW5pY2F0aW9uLkNhbWVyYUFyZ3NSCmNhbWVyYUFyZ3MSHgoKdG9yY2hTdGF0ZRgDIAEoCFIKdG9yY2hTdGF0ZQ==');
@$core.Deprecated('Use unbindArgsDescriptor instead')
const UnbindArgs$json = const {
  '1': 'UnbindArgs',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
  ],
};

/// Descriptor for `UnbindArgs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unbindArgsDescriptor = $convert.base64Decode('CgpVbmJpbmRBcmdzEhAKA2tleRgBIAEoCVIDa2V5');
@$core.Deprecated('Use torchArgsDescriptor instead')
const TorchArgs$json = const {
  '1': 'TorchArgs',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'state', '3': 2, '4': 1, '5': 8, '10': 'state'},
  ],
};

/// Descriptor for `TorchArgs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List torchArgsDescriptor = $convert.base64Decode('CglUb3JjaEFyZ3MSEAoDa2V5GAEgASgJUgNrZXkSFAoFc3RhdGUYAiABKAhSBXN0YXRl');
@$core.Deprecated('Use cameraArgsDescriptor instead')
const CameraArgs$json = const {
  '1': 'CameraArgs',
  '2': const [
    const {'1': 'textureId', '3': 1, '4': 1, '5': 5, '10': 'textureId'},
    const {'1': 'size', '3': 2, '4': 1, '5': 11, '6': '.communication.CameraSize', '10': 'size'},
    const {'1': 'hasTorch', '3': 3, '4': 1, '5': 8, '10': 'hasTorch'},
  ],
};

/// Descriptor for `CameraArgs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraArgsDescriptor = $convert.base64Decode('CgpDYW1lcmFBcmdzEhwKCXRleHR1cmVJZBgBIAEoBVIJdGV4dHVyZUlkEi0KBHNpemUYAiABKAsyGS5jb21tdW5pY2F0aW9uLkNhbWVyYVNpemVSBHNpemUSGgoIaGFzVG9yY2gYAyABKAhSCGhhc1RvcmNo');
@$core.Deprecated('Use cameraSizeDescriptor instead')
const CameraSize$json = const {
  '1': 'CameraSize',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `CameraSize`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraSizeDescriptor = $convert.base64Decode('CgpDYW1lcmFTaXplEhQKBXdpZHRoGAEgASgFUgV3aWR0aBIWCgZoZWlnaHQYAiABKAVSBmhlaWdodA==');
