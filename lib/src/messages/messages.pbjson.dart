///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use commandCategoryDescriptor instead')
const CommandCategory$json = const {
  '1': 'CommandCategory',
  '2': const [
    const {'1': 'OPEN', '2': 0},
    const {'1': 'CLOSE', '2': 1},
    const {'1': 'TORCH', '2': 2},
    const {'1': 'ZOOM', '2': 3},
    const {'1': 'CLOSE_IMAGE_PROXY', '2': 4},
  ],
};

/// Descriptor for `CommandCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandCategoryDescriptor = $convert.base64Decode(
    'Cg9Db21tYW5kQ2F0ZWdvcnkSCAoET1BFThAAEgkKBUNMT1NFEAESCQoFVE9SQ0gQAhIICgRaT09NEAMSFQoRQ0xPU0VfSU1BR0VfUFJPWFkQBA==');
@$core.Deprecated('Use eventCategoryDescriptor instead')
const EventCategory$json = const {
  '1': 'EventCategory',
  '2': const [
    const {'1': 'QUARTER_TURNS_CHANGED', '2': 0},
    const {'1': 'TORCH_STATE_CHANGED', '2': 1},
    const {'1': 'ZOOM_VALUE_CHANGED', '2': 2},
    const {'1': 'IMAGE_PROXY_RECEIVED', '2': 3},
  ],
};

/// Descriptor for `EventCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventCategoryDescriptor = $convert.base64Decode(
    'Cg1FdmVudENhdGVnb3J5EhkKFVFVQVJURVJfVFVSTlNfQ0hBTkdFRBAAEhcKE1RPUkNIX1NUQVRFX0NIQU5HRUQQARIWChJaT09NX1ZBTFVFX0NIQU5HRUQQAhIYChRJTUFHRV9QUk9YWV9SRUNFSVZFRBAD');
@$core.Deprecated('Use cameraFacingDescriptor instead')
const CameraFacing$json = const {
  '1': 'CameraFacing',
  '2': const [
    const {'1': 'BACK', '2': 0},
    const {'1': 'FRONT', '2': 1},
  ],
};

/// Descriptor for `CameraFacing`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cameraFacingDescriptor =
    $convert.base64Decode('CgxDYW1lcmFGYWNpbmcSCAoEQkFDSxAAEgkKBUZST05UEAE=');
@$core.Deprecated('Use commandDescriptor instead')
const Command$json = const {
  '1': 'Command',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {
      '1': 'category',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.messages.CommandCategory',
      '10': 'category'
    },
    const {
      '1': 'open_arguments',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.messages.OpenArguments',
      '9': 0,
      '10': 'openArguments'
    },
    const {
      '1': 'torch_state',
      '3': 4,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'torchState'
    },
    const {
      '1': 'zoom_value',
      '3': 5,
      '4': 1,
      '5': 1,
      '9': 0,
      '10': 'zoomValue'
    },
  ],
  '8': const [
    const {'1': 'stub'},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEhAKA2tleRgBIAEoCVIDa2V5EjUKCGNhdGVnb3J5GAIgASgOMhkubWVzc2FnZXMuQ29tbWFuZENhdGVnb3J5UghjYXRlZ29yeRJACg5vcGVuX2FyZ3VtZW50cxgDIAEoCzIXLm1lc3NhZ2VzLk9wZW5Bcmd1bWVudHNIAFINb3BlbkFyZ3VtZW50cxIhCgt0b3JjaF9zdGF0ZRgEIAEoCEgAUgp0b3JjaFN0YXRlEh8KCnpvb21fdmFsdWUYBSABKAFIAFIJem9vbVZhbHVlQgYKBHN0dWI=');
@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {
      '1': 'category',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.messages.EventCategory',
      '10': 'category'
    },
    const {
      '1': 'quarterTurns',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'quarterTurns'
    },
    const {
      '1': 'torch_state',
      '3': 4,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'torchState'
    },
    const {
      '1': 'zoom_value',
      '3': 5,
      '4': 1,
      '5': 1,
      '9': 0,
      '10': 'zoomValue'
    },
    const {
      '1': 'image',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.messages.ImageProxy',
      '9': 0,
      '10': 'image'
    },
  ],
  '8': const [
    const {'1': 'stub'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIQCgNrZXkYASABKAlSA2tleRIzCghjYXRlZ29yeRgCIAEoDjIXLm1lc3NhZ2VzLkV2ZW50Q2F0ZWdvcnlSCGNhdGVnb3J5EiQKDHF1YXJ0ZXJUdXJucxgDIAEoBUgAUgxxdWFydGVyVHVybnMSIQoLdG9yY2hfc3RhdGUYBCABKAhIAFIKdG9yY2hTdGF0ZRIfCgp6b29tX3ZhbHVlGAUgASgBSABSCXpvb21WYWx1ZRIsCgVpbWFnZRgGIAEoCzIULm1lc3NhZ2VzLkltYWdlUHJveHlIAFIFaW1hZ2VCBgoEc3R1Yg==');
@$core.Deprecated('Use openArgumentsDescriptor instead')
const OpenArguments$json = const {
  '1': 'OpenArguments',
  '2': const [
    const {
      '1': 'selector',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraSelector',
      '10': 'selector'
    },
  ],
};

/// Descriptor for `OpenArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openArgumentsDescriptor = $convert.base64Decode(
    'Cg1PcGVuQXJndW1lbnRzEjQKCHNlbGVjdG9yGAEgASgLMhgubWVzc2FnZXMuQ2FtZXJhU2VsZWN0b3JSCHNlbGVjdG9y');
@$core.Deprecated('Use cameraSelectorDescriptor instead')
const CameraSelector$json = const {
  '1': 'CameraSelector',
  '2': const [
    const {
      '1': 'facing',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.messages.CameraFacing',
      '10': 'facing'
    },
  ],
};

/// Descriptor for `CameraSelector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraSelectorDescriptor = $convert.base64Decode(
    'Cg5DYW1lcmFTZWxlY3RvchIuCgZmYWNpbmcYASABKA4yFi5tZXNzYWdlcy5DYW1lcmFGYWNpbmdSBmZhY2luZw==');
@$core.Deprecated('Use cameraValueDescriptor instead')
const CameraValue$json = const {
  '1': 'CameraValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {
      '1': 'texture_value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.messages.TextureValue',
      '10': 'textureValue'
    },
    const {
      '1': 'torch_value',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.messages.TorchValue',
      '10': 'torchValue'
    },
    const {
      '1': 'zoom_value',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.messages.ZoomValue',
      '10': 'zoomValue'
    },
  ],
};

/// Descriptor for `CameraValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraValueDescriptor = $convert.base64Decode(
    'CgtDYW1lcmFWYWx1ZRIQCgNrZXkYASABKAlSA2tleRI7Cg10ZXh0dXJlX3ZhbHVlGAIgASgLMhYubWVzc2FnZXMuVGV4dHVyZVZhbHVlUgx0ZXh0dXJlVmFsdWUSNQoLdG9yY2hfdmFsdWUYAyABKAsyFC5tZXNzYWdlcy5Ub3JjaFZhbHVlUgp0b3JjaFZhbHVlEjIKCnpvb21fdmFsdWUYBCABKAsyEy5tZXNzYWdlcy5ab29tVmFsdWVSCXpvb21WYWx1ZQ==');
@$core.Deprecated('Use textureValueDescriptor instead')
const TextureValue$json = const {
  '1': 'TextureValue',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'width', '3': 2, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'quarterTurns', '3': 4, '4': 1, '5': 5, '10': 'quarterTurns'},
  ],
};

/// Descriptor for `TextureValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textureValueDescriptor = $convert.base64Decode(
    'CgxUZXh0dXJlVmFsdWUSDgoCaWQYASABKAVSAmlkEhQKBXdpZHRoGAIgASgFUgV3aWR0aBIWCgZoZWlnaHQYAyABKAVSBmhlaWdodBIiCgxxdWFydGVyVHVybnMYBCABKAVSDHF1YXJ0ZXJUdXJucw==');
@$core.Deprecated('Use torchValueDescriptor instead')
const TorchValue$json = const {
  '1': 'TorchValue',
  '2': const [
    const {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    const {'1': 'state', '3': 2, '4': 1, '5': 8, '10': 'state'},
  ],
};

/// Descriptor for `TorchValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List torchValueDescriptor = $convert.base64Decode(
    'CgpUb3JjaFZhbHVlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYXZhaWxhYmxlEhQKBXN0YXRlGAIgASgIUgVzdGF0ZQ==');
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
final $typed_data.Uint8List zoomValueDescriptor = $convert.base64Decode(
    'Cglab29tVmFsdWUSGAoHbWluaW11bRgBIAEoAVIHbWluaW11bRIYCgdtYXhpbXVtGAIgASgBUgdtYXhpbXVtEhQKBXZhbHVlGAMgASgBUgV2YWx1ZQ==');
@$core.Deprecated('Use imageProxyDescriptor instead')
const ImageProxy$json = const {
  '1': 'ImageProxy',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    const {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `ImageProxy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageProxyDescriptor = $convert.base64Decode(
    'CgpJbWFnZVByb3h5EhAKA2tleRgBIAEoCVIDa2V5EhIKBGRhdGEYAiABKAxSBGRhdGESFAoFd2lkdGgYAyABKAVSBXdpZHRoEhYKBmhlaWdodBgEIAEoBVIGaGVpZ2h0');
