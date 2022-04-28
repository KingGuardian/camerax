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
    const {'1': 'COMMAND_CATEGORY_GET_QUARTER_TURNS', '2': 0},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_BIND', '2': 1},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_UNBIND', '2': 2},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_TORCH', '2': 3},
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_ZOOM', '2': 4},
    const {
      '1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_AUTOMATICALLY',
      '2': 5
    },
    const {'1': 'COMMAND_CATEGORY_CAMERA_CONTROLLER_FOCUS_MANUALLY', '2': 6},
    const {'1': 'COMMAND_CATEGORY_IMAGE_PROXY_CLOSE', '2': 7},
  ],
};

/// Descriptor for `CommandCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandCategoryDescriptor = $convert.base64Decode(
    'Cg9Db21tYW5kQ2F0ZWdvcnkSJgoiQ09NTUFORF9DQVRFR09SWV9HRVRfUVVBUlRFUl9UVVJOUxAAEisKJ0NPTU1BTkRfQ0FURUdPUllfQ0FNRVJBX0NPTlRST0xMRVJfQklORBABEi0KKUNPTU1BTkRfQ0FURUdPUllfQ0FNRVJBX0NPTlRST0xMRVJfVU5CSU5EEAISLAooQ09NTUFORF9DQVRFR09SWV9DQU1FUkFfQ09OVFJPTExFUl9UT1JDSBADEisKJ0NPTU1BTkRfQ0FURUdPUllfQ0FNRVJBX0NPTlRST0xMRVJfWk9PTRAEEjoKNkNPTU1BTkRfQ0FURUdPUllfQ0FNRVJBX0NPTlRST0xMRVJfRk9DVVNfQVVUT01BVElDQUxMWRAFEjUKMUNPTU1BTkRfQ0FURUdPUllfQ0FNRVJBX0NPTlRST0xMRVJfRk9DVVNfTUFOVUFMTFkQBhImCiJDT01NQU5EX0NBVEVHT1JZX0lNQUdFX1BST1hZX0NMT1NFEAc=');
@$core.Deprecated('Use eventCategoryDescriptor instead')
const EventCategory$json = const {
  '1': 'EventCategory',
  '2': const [
    const {'1': 'EVENT_CATEGORY_QUARTER_TURNS_CHANGED', '2': 0},
    const {'1': 'EVENT_CATEGORY_CAMERA_CONTROLLER_IMAGE_PROXIED', '2': 1},
  ],
};

/// Descriptor for `EventCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventCategoryDescriptor = $convert.base64Decode(
    'Cg1FdmVudENhdGVnb3J5EigKJEVWRU5UX0NBVEVHT1JZX1FVQVJURVJfVFVSTlNfQ0hBTkdFRBAAEjIKLkVWRU5UX0NBVEVHT1JZX0NBTUVSQV9DT05UUk9MTEVSX0lNQUdFX1BST1hJRUQQAQ==');
@$core.Deprecated('Use cameraFacingDescriptor instead')
const CameraFacing$json = const {
  '1': 'CameraFacing',
  '2': const [
    const {'1': 'CAMERA_FACING_BACK', '2': 0},
    const {'1': 'CAMERA_FACING_FRONT', '2': 1},
  ],
};

/// Descriptor for `CameraFacing`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cameraFacingDescriptor = $convert.base64Decode(
    'CgxDYW1lcmFGYWNpbmcSFgoSQ0FNRVJBX0ZBQ0lOR19CQUNLEAASFwoTQ0FNRVJBX0ZBQ0lOR19GUk9OVBAB');
@$core.Deprecated('Use commandDescriptor instead')
const Command$json = const {
  '1': 'Command',
  '2': const [
    const {
      '1': 'category',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.messages.CommandCategory',
      '10': 'category'
    },
    const {
      '1': 'camera_controller_bind_arguments',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerBindCommandArguments',
      '9': 0,
      '10': 'cameraControllerBindArguments'
    },
    const {
      '1': 'camera_controller_unbind_arguments',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerUnbindCommandArguments',
      '9': 0,
      '10': 'cameraControllerUnbindArguments'
    },
    const {
      '1': 'camera_controller_torch_arguments',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerTorchCommandArguments',
      '9': 0,
      '10': 'cameraControllerTorchArguments'
    },
    const {
      '1': 'camera_controller_zoom_arguments',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerZoomCommandArguments',
      '9': 0,
      '10': 'cameraControllerZoomArguments'
    },
    const {
      '1': 'camera_controller_focus_automatically_arguments',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerFocusAutomaticallyCommandArguments',
      '9': 0,
      '10': 'cameraControllerFocusAutomaticallyArguments'
    },
    const {
      '1': 'camera_controller_focus_manually_arguments',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerFocusManuallyCommandArguments',
      '9': 0,
      '10': 'cameraControllerFocusManuallyArguments'
    },
    const {
      '1': 'image_proxy_close_arguments',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.messages.ImageProxyCloseCommandArguments',
      '9': 0,
      '10': 'imageProxyCloseArguments'
    },
  ],
  '8': const [
    const {'1': 'arguments'},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEjUKCGNhdGVnb3J5GAEgASgOMhkubWVzc2FnZXMuQ29tbWFuZENhdGVnb3J5UghjYXRlZ29yeRJ5CiBjYW1lcmFfY29udHJvbGxlcl9iaW5kX2FyZ3VtZW50cxgCIAEoCzIuLm1lc3NhZ2VzLkNhbWVyYUNvbnRyb2xsZXJCaW5kQ29tbWFuZEFyZ3VtZW50c0gAUh1jYW1lcmFDb250cm9sbGVyQmluZEFyZ3VtZW50cxJ/CiJjYW1lcmFfY29udHJvbGxlcl91bmJpbmRfYXJndW1lbnRzGAMgASgLMjAubWVzc2FnZXMuQ2FtZXJhQ29udHJvbGxlclVuYmluZENvbW1hbmRBcmd1bWVudHNIAFIfY2FtZXJhQ29udHJvbGxlclVuYmluZEFyZ3VtZW50cxJ8CiFjYW1lcmFfY29udHJvbGxlcl90b3JjaF9hcmd1bWVudHMYBCABKAsyLy5tZXNzYWdlcy5DYW1lcmFDb250cm9sbGVyVG9yY2hDb21tYW5kQXJndW1lbnRzSABSHmNhbWVyYUNvbnRyb2xsZXJUb3JjaEFyZ3VtZW50cxJ5CiBjYW1lcmFfY29udHJvbGxlcl96b29tX2FyZ3VtZW50cxgFIAEoCzIuLm1lc3NhZ2VzLkNhbWVyYUNvbnRyb2xsZXJab29tQ29tbWFuZEFyZ3VtZW50c0gAUh1jYW1lcmFDb250cm9sbGVyWm9vbUFyZ3VtZW50cxKkAQovY2FtZXJhX2NvbnRyb2xsZXJfZm9jdXNfYXV0b21hdGljYWxseV9hcmd1bWVudHMYBiABKAsyPC5tZXNzYWdlcy5DYW1lcmFDb250cm9sbGVyRm9jdXNBdXRvbWF0aWNhbGx5Q29tbWFuZEFyZ3VtZW50c0gAUitjYW1lcmFDb250cm9sbGVyRm9jdXNBdXRvbWF0aWNhbGx5QXJndW1lbnRzEpUBCipjYW1lcmFfY29udHJvbGxlcl9mb2N1c19tYW51YWxseV9hcmd1bWVudHMYByABKAsyNy5tZXNzYWdlcy5DYW1lcmFDb250cm9sbGVyRm9jdXNNYW51YWxseUNvbW1hbmRBcmd1bWVudHNIAFImY2FtZXJhQ29udHJvbGxlckZvY3VzTWFudWFsbHlBcmd1bWVudHMSagobaW1hZ2VfcHJveHlfY2xvc2VfYXJndW1lbnRzGAggASgLMikubWVzc2FnZXMuSW1hZ2VQcm94eUNsb3NlQ29tbWFuZEFyZ3VtZW50c0gAUhhpbWFnZVByb3h5Q2xvc2VBcmd1bWVudHNCCwoJYXJndW1lbnRz');
@$core.Deprecated('Use cameraControllerBindCommandArgumentsDescriptor instead')
const CameraControllerBindCommandArguments$json = const {
  '1': 'CameraControllerBindCommandArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {
      '1': 'selector',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraSelector',
      '10': 'selector'
    },
  ],
};

/// Descriptor for `CameraControllerBindCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraControllerBindCommandArgumentsDescriptor =
    $convert.base64Decode(
        'CiRDYW1lcmFDb250cm9sbGVyQmluZENvbW1hbmRBcmd1bWVudHMSDgoCaWQYASABKAlSAmlkEjQKCHNlbGVjdG9yGAIgASgLMhgubWVzc2FnZXMuQ2FtZXJhU2VsZWN0b3JSCHNlbGVjdG9y');
@$core
    .Deprecated('Use cameraControllerUnbindCommandArgumentsDescriptor instead')
const CameraControllerUnbindCommandArguments$json = const {
  '1': 'CameraControllerUnbindCommandArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `CameraControllerUnbindCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraControllerUnbindCommandArgumentsDescriptor =
    $convert.base64Decode(
        'CiZDYW1lcmFDb250cm9sbGVyVW5iaW5kQ29tbWFuZEFyZ3VtZW50cxIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use cameraControllerTorchCommandArgumentsDescriptor instead')
const CameraControllerTorchCommandArguments$json = const {
  '1': 'CameraControllerTorchCommandArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'state', '3': 2, '4': 1, '5': 8, '10': 'state'},
  ],
};

/// Descriptor for `CameraControllerTorchCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraControllerTorchCommandArgumentsDescriptor =
    $convert.base64Decode(
        'CiVDYW1lcmFDb250cm9sbGVyVG9yY2hDb21tYW5kQXJndW1lbnRzEg4KAmlkGAEgASgJUgJpZBIUCgVzdGF0ZRgCIAEoCFIFc3RhdGU=');
@$core.Deprecated('Use cameraControllerZoomCommandArgumentsDescriptor instead')
const CameraControllerZoomCommandArguments$json = const {
  '1': 'CameraControllerZoomCommandArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `CameraControllerZoomCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraControllerZoomCommandArgumentsDescriptor =
    $convert.base64Decode(
        'CiRDYW1lcmFDb250cm9sbGVyWm9vbUNvbW1hbmRBcmd1bWVudHMSDgoCaWQYASABKAlSAmlkEhQKBXZhbHVlGAIgASgBUgV2YWx1ZQ==');
@$core.Deprecated(
    'Use cameraControllerFocusAutomaticallyCommandArgumentsDescriptor instead')
const CameraControllerFocusAutomaticallyCommandArguments$json = const {
  '1': 'CameraControllerFocusAutomaticallyCommandArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `CameraControllerFocusAutomaticallyCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    cameraControllerFocusAutomaticallyCommandArgumentsDescriptor =
    $convert.base64Decode(
        'CjJDYW1lcmFDb250cm9sbGVyRm9jdXNBdXRvbWF0aWNhbGx5Q29tbWFuZEFyZ3VtZW50cxIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated(
    'Use cameraControllerFocusManuallyCommandArgumentsDescriptor instead')
const CameraControllerFocusManuallyCommandArguments$json = const {
  '1': 'CameraControllerFocusManuallyCommandArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'width', '3': 2, '4': 1, '5': 1, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 1, '10': 'height'},
    const {'1': 'x', '3': 4, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 5, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `CameraControllerFocusManuallyCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    cameraControllerFocusManuallyCommandArgumentsDescriptor =
    $convert.base64Decode(
        'Ci1DYW1lcmFDb250cm9sbGVyRm9jdXNNYW51YWxseUNvbW1hbmRBcmd1bWVudHMSDgoCaWQYASABKAlSAmlkEhQKBXdpZHRoGAIgASgBUgV3aWR0aBIWCgZoZWlnaHQYAyABKAFSBmhlaWdodBIMCgF4GAQgASgBUgF4EgwKAXkYBSABKAFSAXk=');
@$core.Deprecated('Use imageProxyCloseCommandArgumentsDescriptor instead')
const ImageProxyCloseCommandArguments$json = const {
  '1': 'ImageProxyCloseCommandArguments',
  '2': const [
    const {'1': 'controller_id', '3': 1, '4': 1, '5': 9, '10': 'controllerId'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `ImageProxyCloseCommandArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageProxyCloseCommandArgumentsDescriptor =
    $convert.base64Decode(
        'Ch9JbWFnZVByb3h5Q2xvc2VDb21tYW5kQXJndW1lbnRzEiMKDWNvbnRyb2xsZXJfaWQYASABKAlSDGNvbnRyb2xsZXJJZBIOCgJpZBgCIAEoCVICaWQ=');
@$core.Deprecated('Use replyDescriptor instead')
const Reply$json = const {
  '1': 'Reply',
  '2': const [
    const {
      '1': 'get_quarter_turns_arguments',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.messages.GetQuarterTurnsReplyArguments',
      '9': 0,
      '10': 'getQuarterTurnsArguments'
    },
    const {
      '1': 'camera_controller_bind_arguments',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerBindReplyArguments',
      '9': 0,
      '10': 'cameraControllerBindArguments'
    },
  ],
  '8': const [
    const {'1': 'arguments'},
  ],
};

/// Descriptor for `Reply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replyDescriptor = $convert.base64Decode(
    'CgVSZXBseRJoChtnZXRfcXVhcnRlcl90dXJuc19hcmd1bWVudHMYASABKAsyJy5tZXNzYWdlcy5HZXRRdWFydGVyVHVybnNSZXBseUFyZ3VtZW50c0gAUhhnZXRRdWFydGVyVHVybnNBcmd1bWVudHMSdwogY2FtZXJhX2NvbnRyb2xsZXJfYmluZF9hcmd1bWVudHMYAiABKAsyLC5tZXNzYWdlcy5DYW1lcmFDb250cm9sbGVyQmluZFJlcGx5QXJndW1lbnRzSABSHWNhbWVyYUNvbnRyb2xsZXJCaW5kQXJndW1lbnRzQgsKCWFyZ3VtZW50cw==');
@$core.Deprecated('Use getQuarterTurnsReplyArgumentsDescriptor instead')
const GetQuarterTurnsReplyArguments$json = const {
  '1': 'GetQuarterTurnsReplyArguments',
  '2': const [
    const {'1': 'quarter_turns', '3': 1, '4': 1, '5': 5, '10': 'quarterTurns'},
  ],
};

/// Descriptor for `GetQuarterTurnsReplyArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuarterTurnsReplyArgumentsDescriptor =
    $convert.base64Decode(
        'Ch1HZXRRdWFydGVyVHVybnNSZXBseUFyZ3VtZW50cxIjCg1xdWFydGVyX3R1cm5zGAEgASgFUgxxdWFydGVyVHVybnM=');
@$core.Deprecated('Use cameraControllerBindReplyArgumentsDescriptor instead')
const CameraControllerBindReplyArguments$json = const {
  '1': 'CameraControllerBindReplyArguments',
  '2': const [
    const {
      '1': 'camera_value',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraValue',
      '10': 'cameraValue'
    },
  ],
};

/// Descriptor for `CameraControllerBindReplyArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraControllerBindReplyArgumentsDescriptor =
    $convert.base64Decode(
        'CiJDYW1lcmFDb250cm9sbGVyQmluZFJlcGx5QXJndW1lbnRzEjgKDGNhbWVyYV92YWx1ZRgBIAEoCzIVLm1lc3NhZ2VzLkNhbWVyYVZhbHVlUgtjYW1lcmFWYWx1ZQ==');
@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {
      '1': 'category',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.messages.EventCategory',
      '10': 'category'
    },
    const {
      '1': 'quarter_turns_changed_arguments',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.messages.QuarterTurnsChangedEventArguments',
      '9': 0,
      '10': 'quarterTurnsChangedArguments'
    },
    const {
      '1': 'camera_controller_image_proxied_arguments',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.messages.CameraControllerImageProxiedEventArguments',
      '9': 0,
      '10': 'cameraControllerImageProxiedArguments'
    },
  ],
  '8': const [
    const {'1': 'arguments'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIzCghjYXRlZ29yeRgBIAEoDjIXLm1lc3NhZ2VzLkV2ZW50Q2F0ZWdvcnlSCGNhdGVnb3J5EnQKH3F1YXJ0ZXJfdHVybnNfY2hhbmdlZF9hcmd1bWVudHMYAiABKAsyKy5tZXNzYWdlcy5RdWFydGVyVHVybnNDaGFuZ2VkRXZlbnRBcmd1bWVudHNIAFIccXVhcnRlclR1cm5zQ2hhbmdlZEFyZ3VtZW50cxKQAQopY2FtZXJhX2NvbnRyb2xsZXJfaW1hZ2VfcHJveGllZF9hcmd1bWVudHMYAyABKAsyNC5tZXNzYWdlcy5DYW1lcmFDb250cm9sbGVySW1hZ2VQcm94aWVkRXZlbnRBcmd1bWVudHNIAFIlY2FtZXJhQ29udHJvbGxlckltYWdlUHJveGllZEFyZ3VtZW50c0ILCglhcmd1bWVudHM=');
@$core.Deprecated('Use quarterTurnsChangedEventArgumentsDescriptor instead')
const QuarterTurnsChangedEventArguments$json = const {
  '1': 'QuarterTurnsChangedEventArguments',
  '2': const [
    const {'1': 'quarter_turns', '3': 1, '4': 1, '5': 5, '10': 'quarterTurns'},
  ],
};

/// Descriptor for `QuarterTurnsChangedEventArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quarterTurnsChangedEventArgumentsDescriptor =
    $convert.base64Decode(
        'CiFRdWFydGVyVHVybnNDaGFuZ2VkRXZlbnRBcmd1bWVudHMSIwoNcXVhcnRlcl90dXJucxgBIAEoBVIMcXVhcnRlclR1cm5z');
@$core.Deprecated(
    'Use cameraControllerImageProxiedEventArgumentsDescriptor instead')
const CameraControllerImageProxiedEventArguments$json = const {
  '1': 'CameraControllerImageProxiedEventArguments',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {
      '1': 'image_proxy',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.messages.ImageProxy',
      '10': 'imageProxy'
    },
  ],
};

/// Descriptor for `CameraControllerImageProxiedEventArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    cameraControllerImageProxiedEventArgumentsDescriptor =
    $convert.base64Decode(
        'CipDYW1lcmFDb250cm9sbGVySW1hZ2VQcm94aWVkRXZlbnRBcmd1bWVudHMSDgoCaWQYASABKAlSAmlkEjUKC2ltYWdlX3Byb3h5GAIgASgLMhQubWVzc2FnZXMuSW1hZ2VQcm94eVIKaW1hZ2VQcm94eQ==');
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
    const {'1': 'texture_id', '3': 1, '4': 1, '5': 5, '10': 'textureId'},
    const {'1': 'texture_width', '3': 2, '4': 1, '5': 5, '10': 'textureWidth'},
    const {
      '1': 'texture_height',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'textureHeight'
    },
    const {
      '1': 'torch_available',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'torchAvailable'
    },
    const {'1': 'zoom_minimum', '3': 5, '4': 1, '5': 1, '10': 'zoomMinimum'},
    const {'1': 'zoom_maximum', '3': 6, '4': 1, '5': 1, '10': 'zoomMaximum'},
  ],
};

/// Descriptor for `CameraValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraValueDescriptor = $convert.base64Decode(
    'CgtDYW1lcmFWYWx1ZRIdCgp0ZXh0dXJlX2lkGAEgASgFUgl0ZXh0dXJlSWQSIwoNdGV4dHVyZV93aWR0aBgCIAEoBVIMdGV4dHVyZVdpZHRoEiUKDnRleHR1cmVfaGVpZ2h0GAMgASgFUg10ZXh0dXJlSGVpZ2h0EicKD3RvcmNoX2F2YWlsYWJsZRgEIAEoCFIOdG9yY2hBdmFpbGFibGUSIQoMem9vbV9taW5pbXVtGAUgASgBUgt6b29tTWluaW11bRIhCgx6b29tX21heGltdW0YBiABKAFSC3pvb21NYXhpbXVt');
@$core.Deprecated('Use imageProxyDescriptor instead')
const ImageProxy$json = const {
  '1': 'ImageProxy',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    const {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `ImageProxy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageProxyDescriptor = $convert.base64Decode(
    'CgpJbWFnZVByb3h5Eg4KAmlkGAEgASgJUgJpZBISCgRkYXRhGAIgASgMUgRkYXRhEhQKBXdpZHRoGAMgASgFUgV3aWR0aBIWCgZoZWlnaHQYBCABKAVSBmhlaWdodA==');
