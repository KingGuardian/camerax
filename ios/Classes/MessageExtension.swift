//
//  MessageExtension.swift
//  camerax
//
//  Created by 铁臂 on 2022/5/6.
//

import Foundation

extension Messages_Reply {
    
    public static func withPermission (
      _ populator: (inout PermissionReplyArguments) throws -> ()
    ) rethrows -> Self {
        var message = Self()
        var permissionArguments = PermissionReplyArguments.init()
        try populator(&permissionArguments)
        message.cameraControllerRequestPermissionArguments = permissionArguments
        return message
    }
    
    public static func withBind (
      _ populator: (inout Messages_CameraControllerBindReplyArguments) throws -> ()
    ) rethrows -> Self {
        var message = Self()
        var bindArguments = Messages_CameraControllerBindReplyArguments.init()
        try populator(&bindArguments)
        message.cameraControllerBindArguments = bindArguments
        return message
    }
    
    public static func withQuarterTurns (
      _ populator: (inout QuarterTurnsArguments) throws -> ()
    ) rethrows -> Self {
        var message = Self()
        var quarterArguments = QuarterTurnsArguments.init()
        try populator(&quarterArguments)
        message.getQuarterTurnsArguments = quarterArguments
        return message
    }
}

extension Messages_Event {
    
    public static func withImageProxy (
      _ populator: (inout EventImageProxyArguments) throws -> ()
    ) rethrows -> Self {
        var message = Self()
        var proxyArguments = EventImageProxyArguments.init()
        try populator(&proxyArguments)
        message.cameraControllerImageProxiedArguments = proxyArguments
        return message
    }
}
