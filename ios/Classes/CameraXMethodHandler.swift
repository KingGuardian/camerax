//
//  CameraControllerChannel.swift
//  camerax
//
//  Created by 铁臂 on 2022/5/2.
//

import Foundation
import Flutter
import AVFoundation

public class CameraXMethodHandler: NSObject, FlutterPlugin {
    
    private var cameraController: CameraController?
    private var mRegistrar: FlutterPluginRegistrar
    
    //屏幕旋转角度,不旋转对应0，旋转90度对应3，旋转180度对应2，旋转270度对应1
    private var quarterTurns: Int32 = 0
    
    init(registrar: FlutterPluginRegistrar) {
        mRegistrar = registrar
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
    }
    
    //MARK: 插件方法回调处理
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let command = call.command
        switch command.category {
            //获取屏幕方向？
            case.getQuarterTurns:
                handleGetQuarterTurns(call: call, result: result)
            //申请相机权限
            case .cameraControllerRequestPermission:
                handleRequestPermission(call: call, result: result)
            //开始获取相机预览信息等
            case .cameraControllerBind:
                cameraController = CameraController.init(mRegistrar.textures())
                cameraController?.handleBind(bindArguments: command.cameraControllerBindArguments, result: result)
                startScreenOrientationListener()
            //接触数据绑定
            case .cameraControllerUnbind:
                cameraController?.handleUnbind(result: result)
            //暂时不考虑关闭，防止在unbind后屏幕发生变化，导致方向错误的情况
//                stopScreenOrientationListener()
            //打开和关闭手电筒
            case .cameraControllerTorch:
                cameraController?.handleTorch(torchArguments: command.cameraControllerTorchArguments, result: result)
            //相机缩放
            case .cameraControllerZoom:
                cameraController?.handleZoom(zoomArguments: command.cameraControllerZoomArguments, result: result)
            //关闭上一张分析的图片
            case .imageProxyClose:
                cameraController?.handleImageProxyClose(proxyArguments: command.imageProxyCloseArguments, result: result)
            case .cameraControllerFocusAutomatically:
                cameraController?.handleFocusAutomatically(automaticallyArguments: command.cameraControllerFocusAutomaticallyArguments, result: result)
            case .cameraControllerFocusManually:
                cameraController?.handleFocusManually(manuallyArguments: command.cameraControllerFocusManuallyArguments, result: result)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
}

extension CameraXMethodHandler {
    
    //获取相机权限
    private func handleRequestPermission(call: FlutterMethodCall, result: @escaping FlutterResult) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            let replyData = try! Messages_Reply.withPermission { permission in
                permission.granted = granted
            }.serializedData()
            result(replyData)
        })
    }
    
    //获取屏幕方向？
    private func handleGetQuarterTurns(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let resultData = try! Messages_Reply.withQuarterTurns({ quarterModel in
            quarterModel.quarterTurns = quarterTurns
        }).serializedData()
        result(resultData)
    }
    
}


//MARK: 屏幕方向相关方法
extension CameraXMethodHandler {
    
    
    
    //开始监听屏幕状态变化
    private func startScreenOrientationListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(onScreenOritationChanged(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    //开始监听屏幕状态变化
    private func stopScreenOrientationListener() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func onScreenOritationChanged(notification: NSNotification) {
        
        let device = notification.object as? UIDevice
        let oritation = device?.orientation ?? .portrait
        if oritation == .faceUp || oritation == .faceDown {
            return
        }
 
        switch oritation {
        case .unknown:
            quarterTurns = 0
        case .portrait:
            quarterTurns = 0
        case .portraitUpsideDown:
            quarterTurns = 2
        case .landscapeLeft:
            quarterTurns = 1
        case .landscapeRight:
            quarterTurns = 3
        default:
            quarterTurns = 0
        }
        
        //给当前的camera controller 设置方向
        cameraController?.setDeviceOrientation(orientation: oritation)
        
        //将方向发送给dart侧
        let oritationData = try! Messages_Event.with { event in
            var quarterModel = Messages_QuarterTurnsChangedEventArguments.init()
            quarterModel.quarterTurns = self.quarterTurns
            event.quarterTurnsChangedArguments = quarterModel
        }.serializedData()
        eventHandler.send(data: oritationData)
    }
}
