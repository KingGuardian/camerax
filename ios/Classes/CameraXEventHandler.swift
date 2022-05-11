//
//  CameraEventChanndel.swift
//  camerax
//
//  Created by 铁臂 on 2022/5/2.
//

import Foundation
import Flutter

public let eventHandler = CameraxEventHandler.init()

public class CameraxEventHandler: NSObject, FlutterStreamHandler {
    
    private var events: FlutterEventSink?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        events = nil
        return nil
    }
    
    public func send(data: Data) {
        events?(data)
    }
}
