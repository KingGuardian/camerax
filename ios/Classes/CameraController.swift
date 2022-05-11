//
//  NativeCamera.swift
//  camerax
//
//  Created by 闫守旺 on 2021/11/16.
//

import Foundation
import AVFoundation
import SwiftProtobuf

class CameraController: NSObject, FlutterTexture, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //外接纹理
    private var textureId: Int64 = 0
    private let textureRegistry: FlutterTextureRegistry
    //camera相关
    private var captureSession: AVCaptureSession?
    private var device: AVCaptureDevice?
    //上一个识别的帧数据
    private var latestBuffer: CVImageBuffer?
    
    private var isAnalysing = false
    
    private var deviceOrientation: UIDeviceOrientation = .portrait
    private var videoOutput = AVCaptureVideoDataOutput()
    
    init(_ textureRegistry: FlutterTextureRegistry) {
        self.textureRegistry = textureRegistry
    }
    
    func copyPixelBuffer() -> Unmanaged<CVPixelBuffer>? {
        guard let buffet = latestBuffer else {
            return nil
        }
        return Unmanaged<CVPixelBuffer>.passRetained(buffet)
    }
    
    /// 执行相机的绑定操作
    public func handleBind(bindArguments: BindArguments, result: @escaping FlutterResult) {
        if captureSession == nil {
            configCamera(bindArguments: bindArguments, result: result)
        }
        
        textureId = textureRegistry.register(self)
        captureSession?.startRunning()
        let size = getVideoSize()

        let bindReplyData = try! Messages_Reply.withBind { bindModel in
            var cameraValueModel = CameraValue.init()
            cameraValueModel.textureID = Int32(textureId)
            cameraValueModel.torchAvailable = device?.isTorchAvailable ?? false
            cameraValueModel.textureWidth = Int32(size?.width ?? 0)
            cameraValueModel.textureHeight = Int32(size?.height ?? 0)
            bindModel.cameraValue = cameraValueModel
        }.serializedData()
        result(bindReplyData)
    }
    
    /// 执行相机的取消绑定操作
    public func handleUnbind(result: @escaping FlutterResult) {
        
        guard let session = captureSession else {
            return
        }
        
        session.stopRunning()
        for input in session.inputs {
            session.removeInput(input)
        }
        for output in session.outputs {
            session.removeOutput(output)
        }
        textureRegistry.unregisterTexture(textureId)

        latestBuffer = nil
        captureSession = nil
        device = nil
        result(nil)
    }
    
    /// 执行相机的手电筒操作
    public func handleTorch(torchArguments: TorchArguments, result: @escaping FlutterResult) {
        do {
            try device?.lockForConfiguration()
            device?.torchMode = torchArguments.state ? .on : .off
            device?.unlockForConfiguration()
            result(nil)
        } catch {
            error.throwToFlutter(result)
        }
    }
    
    
    /// 执行相机的缩放操作
    public func handleZoom(zoomArguments: ZoomArguments, result: @escaping FlutterResult) {
        do {
            try device?.lockForConfiguration()
            device?.videoZoomFactor = zoomArguments.value
            device?.unlockForConfiguration()
        } catch {
            
        }
        result(nil)
    }
    
    /// 上一张图片识别结束
    public func handleImageProxyClose(proxyArguments: ImageProxyCloseArguments, result: FlutterResult) {
        isAnalysing = false
        result(nil)
    }
    
    /// 自动对焦
    public func handleFocusAutomatically(automaticallyArguments: FocusAutomaticallyArguments, result: FlutterResult) {
        applyAutoFocusModel()
        result(nil)
    }
    
    /// 手动对焦
    public func handleFocusManually(manuallyArguments: FocusManuallyArguments, result: FlutterResult) {
        let positionX = manuallyArguments.x
        let positionY = manuallyArguments.y
        
        let width = manuallyArguments.width
        let height = manuallyArguments.height

        let x = positionY / height
        let y = 1.0 - positionX / width
        let focusPoint = CGPoint(x: x, y: y)
        doFocus(focusPoint, result: result)
    }
    
    ///  设置屏幕方向
    public func setDeviceOrientation(orientation: UIDeviceOrientation) {
        if deviceOrientation == orientation {
            return
        }
        deviceOrientation = orientation
        updateOrientation()
    }
    
    deinit {
        latestBuffer = nil
        captureSession = nil
        device = nil
    }
}

//MARK: 私有方法
extension CameraController {
    
    private func configCamera(bindArguments: BindArguments, result: @escaping FlutterResult) {
        
        captureSession = AVCaptureSession()
        let cameraPosition = bindArguments.selector.facing == .back ? AVCaptureDevice.Position.back : .front
        if #available(iOS 10.0, *) {
            device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: cameraPosition).devices.first
        } else {
            device = AVCaptureDevice.devices(for: .video).filter({$0.position == cameraPosition}).first
        }
        
        captureSession?.beginConfiguration()
        // Add device input.
        
        if let tDevice = device {
            do {
                let input = try AVCaptureDeviceInput(device: tDevice)
                captureSession?.addInput(input)
            } catch {
                error.throwToFlutter(result)
            }
        }

        // Add video output.
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        captureSession?.addOutput(videoOutput)
        for connection in videoOutput.connections {
            connection.videoOrientation = .portrait
            if cameraPosition == .front && connection.isVideoMirroringSupported {
                connection.isVideoMirrored = true
            }
        }
        captureSession?.commitConfiguration()
    }
    
    private func applyAutoFocusModel() {
        do {
            try device?.lockForConfiguration()
            if device?.isFocusModeSupported(.continuousAutoFocus) ?? false {
                device?.focusMode = .continuousAutoFocus
            } else if device?.isFocusModeSupported(.autoFocus) ?? false {
                device?.focusMode = .autoFocus
            }
            device?.unlockForConfiguration()
        } catch {
            
        }
    }
    
    private func doFocus(_ focusPoint: CGPoint? = nil, result: FlutterResult) {
        guard let cameraDevice = device else {
            result(nil)
            return
        }
        
        do {
            try cameraDevice.lockForConfiguration()
            if cameraDevice.isFocusPointOfInterestSupported {
                if focusPoint != nil {
                    cameraDevice.focusPointOfInterest = focusPoint ?? CGPoint.init(x: 0, y: 0)
                }
            }
            if focusPoint != nil {
                cameraDevice.exposurePointOfInterest = focusPoint ?? CGPoint.init(x: 0, y: 0)
            }
            cameraDevice.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            cameraDevice.unlockForConfiguration()
        } catch {
            
        }
        applyAutoFocusModel()
        result(nil)
    }
    
    private func getVideoSize() -> CGSize? {
        guard let videoDevice = device else {
            return nil
        }
        let demensions = CMVideoFormatDescriptionGetDimensions(videoDevice.activeFormat.formatDescription)
        let width = Double(demensions.height)
        let height = Double(demensions.width)
        return CGSize.init(width: width, height: height)
    }
    
    //根据设备方向，更新输出的视频方向
    private func updateOrientation() {
        guard let connection = videoOutput.connection(with: .video) else {
            return
        }
        if connection.isVideoOrientationSupported {
            connection.videoOrientation = getVideoOrientationByDevice()
        }
    }
    
    private func getVideoOrientationByDevice() -> AVCaptureVideoOrientation {
        
        var videoOrientation = AVCaptureVideoOrientation.portrait
        switch deviceOrientation {
        case .portrait:
            videoOrientation = .portrait
        case .landscapeLeft:
            videoOrientation = .landscapeRight
        case .landscapeRight:
            videoOrientation = .landscapeLeft
        case.portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
        default:
            break
        }
        return videoOrientation
    }
}

//MARK: 摄像头数据回调
extension CameraController {
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        latestBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        textureRegistry.textureFrameAvailable(textureId)
        
        if !isAnalysing {
            //将获取到得数据流传回dart侧，其实这里可以加一个开关，在对应的handle方法中，添加
            //startImageStream和stop方法，再添加一个状态变量，配合closeProxy使用
            isAnalysing = true
            //发送last buffer到dart侧
            
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                return
            }
            
            var imageProxy = ImageProxy.init()
            var imageWidth = 0
            var imageHeight = 0
            var imageData = Data.init()
            CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
            if let planeAddress = CVPixelBufferGetBaseAddress(pixelBuffer) {
                
                imageWidth = CVPixelBufferGetWidth(pixelBuffer)
                imageHeight = CVPixelBufferGetHeight(pixelBuffer)
                
                let bytePerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
                
                let length = bytePerRow * imageHeight
                imageData = NSData.init(bytesNoCopy: planeAddress, length: length) as Data
            }
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
            
            imageProxy.width = Int32(imageWidth)
            imageProxy.height = Int32(imageHeight)
            imageProxy.data = imageData
            
            let proxyData = try! Messages_Event.withImageProxy { arguments in
                arguments.imageProxy = imageProxy
            }.serializedData()
            
            eventHandler.send(data: proxyData)
        }
    }
}
