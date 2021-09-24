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
    const {'1': 'BIND', '2': 0},
    const {'1': 'UNBIND', '2': 1},
    const {'1': 'TEXTURE_INFO', '2': 2},
    const {'1': 'TEXTURE_INFO_EVENT', '2': 3},
    const {'1': 'TORCH', '2': 4},
    const {'1': 'TORCH_EVENT', '2': 5},
    const {'1': 'ANALYSIS_EVENT', '2': 6},
  ],
};

/// Descriptor for `MessageCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageCategoryDescriptor = $convert.base64Decode('Cg9NZXNzYWdlQ2F0ZWdvcnkSCAoEQklORBAAEgoKBlVOQklORBABEhAKDFRFWFRVUkVfSU5GTxACEhYKElRFWFRVUkVfSU5GT19FVkVOVBADEgkKBVRPUkNIEAQSDwoLVE9SQ0hfRVZFTlQQBRISCg5BTkFMWVNJU19FVkVOVBAG');
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
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    const {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.communication.MessageCategory', '10': 'category'},
    const {'1': 'bind_args', '3': 3, '4': 1, '5': 11, '6': '.communication.BindArgs', '9': 0, '10': 'bindArgs'},
    const {'1': 'texture_info', '3': 4, '4': 1, '5': 11, '6': '.communication.TextureInfo', '9': 0, '10': 'textureInfo'},
    const {'1': 'torch_state', '3': 5, '4': 1, '5': 8, '9': 0, '10': 'torchState'},
    const {'1': 'analysis', '3': 6, '4': 1, '5': 12, '9': 0, '10': 'analysis'},
  ],
  '8': const [
    const {'1': 'stub'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEhAKA2tleRgBIAEoBVIDa2V5EjoKCGNhdGVnb3J5GAIgASgOMh4uY29tbXVuaWNhdGlvbi5NZXNzYWdlQ2F0ZWdvcnlSCGNhdGVnb3J5EjYKCWJpbmRfYXJncxgDIAEoCzIXLmNvbW11bmljYXRpb24uQmluZEFyZ3NIAFIIYmluZEFyZ3MSPwoMdGV4dHVyZV9pbmZvGAQgASgLMhouY29tbXVuaWNhdGlvbi5UZXh0dXJlSW5mb0gAUgt0ZXh0dXJlSW5mbxIhCgt0b3JjaF9zdGF0ZRgFIAEoCEgAUgp0b3JjaFN0YXRlEhwKCGFuYWx5c2lzGAYgASgMSABSCGFuYWx5c2lzQgYKBHN0dWI=');
@$core.Deprecated('Use bindArgsDescriptor instead')
const BindArgs$json = const {
  '1': 'BindArgs',
  '2': const [
    const {'1': 'selector', '3': 2, '4': 1, '5': 11, '6': '.communication.CameraSelector', '10': 'selector'},
  ],
};

/// Descriptor for `BindArgs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bindArgsDescriptor = $convert.base64Decode('CghCaW5kQXJncxI5CghzZWxlY3RvchgCIAEoCzIdLmNvbW11bmljYXRpb24uQ2FtZXJhU2VsZWN0b3JSCHNlbGVjdG9y');
@$core.Deprecated('Use cameraSelectorDescriptor instead')
const CameraSelector$json = const {
  '1': 'CameraSelector',
  '2': const [
    const {'1': 'facing', '3': 1, '4': 1, '5': 14, '6': '.communication.CameraFacing', '10': 'facing'},
  ],
};

/// Descriptor for `CameraSelector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraSelectorDescriptor = $convert.base64Decode('Cg5DYW1lcmFTZWxlY3RvchIzCgZmYWNpbmcYASABKA4yGy5jb21tdW5pY2F0aW9uLkNhbWVyYUZhY2luZ1IGZmFjaW5n');
@$core.Deprecated('Use cameraInfoDescriptor instead')
const CameraInfo$json = const {
  '1': 'CameraInfo',
  '2': const [
    const {'1': 'has_torch', '3': 1, '4': 1, '5': 8, '10': 'hasTorch'},
  ],
};

/// Descriptor for `CameraInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraInfoDescriptor = $convert.base64Decode('CgpDYW1lcmFJbmZvEhsKCWhhc190b3JjaBgBIAEoCFIIaGFzVG9yY2g=');
@$core.Deprecated('Use textureInfoDescriptor instead')
const TextureInfo$json = const {
  '1': 'TextureInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'size', '3': 2, '4': 1, '5': 11, '6': '.communication.TextureSize', '10': 'size'},
    const {'1': 'quarterTurns', '3': 3, '4': 1, '5': 5, '10': 'quarterTurns'},
  ],
};

/// Descriptor for `TextureInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textureInfoDescriptor = $convert.base64Decode('CgtUZXh0dXJlSW5mbxIOCgJpZBgBIAEoBVICaWQSLgoEc2l6ZRgCIAEoCzIaLmNvbW11bmljYXRpb24uVGV4dHVyZVNpemVSBHNpemUSIgoMcXVhcnRlclR1cm5zGAMgASgFUgxxdWFydGVyVHVybnM=');
@$core.Deprecated('Use textureSizeDescriptor instead')
const TextureSize$json = const {
  '1': 'TextureSize',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `TextureSize`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textureSizeDescriptor = $convert.base64Decode('CgtUZXh0dXJlU2l6ZRIUCgV3aWR0aBgBIAEoBVIFd2lkdGgSFgoGaGVpZ2h0GAIgASgFUgZoZWlnaHQ=');
