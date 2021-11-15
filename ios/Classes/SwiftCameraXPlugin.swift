import AVFoundation
import Flutter
import Messages

let NAMESPACE = "yanshouwang.dev/camerax"

typealias Command = Messages_Command
typealias CommandCategory = Messages_CommandCategory
typealias OpenArguments = Messages_OpenArguments
typealias CameraSelector = Messages_CameraSelector
typealias CameraFacing = Messages_CameraFacing
typealias CameraValue = Messages_CameraValue
typealias TextureValue = Messages_TextureValue
typealias TorchValue = Messages_TorchValue
typealias ZoomValue = Messages_ZoomValue
typealias ImageProxy = Messages_ImageProxy
typealias Event = Messages_Event
typealias EventCategory = Messages_EventCategory

public class SwiftCameraXPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, FlutterTexture, AVCaptureVideoDataOutputSampleBufferDelegate {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftCameraXPlugin(registrar)
        let binaryMessenger = registrar.messenger()
        let methodChannel = FlutterMethodChannel(name: "\(NAMESPACE)/method", binaryMessenger: binaryMessenger)
        let eventChannel = FlutterEventChannel(name: "\(NAMESPACE)/event", binaryMessenger: binaryMessenger)
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        eventChannel.setStreamHandler(instance)
    }
    
    let textureRegistry: FlutterTextureRegistry
    var eventSink: FlutterEventSink!
    var textureId: Int64!
    var captureSession: AVCaptureSession!
    var device: AVCaptureDevice!
    var latestBuffer: CVImageBuffer!
    
    init(_ registrar: FlutterPluginRegistrar) {
        textureRegistry = registrar.textures()
        super.init()
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let command = call.command
        switch command.category {
        case .open:
            open(command.openArguments, result)
        case .close:
            close(command.key, result)
        case .torch:
            torch(command.key, command.torchState, result)
        case .zoom:
            zoom(command.key, command.zoomValue, result)
        case .closeImageProxy:
            closeImageProxy(command.key, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    func open(_ openArguments: OpenArguments, _ result: @escaping FlutterResult) {
        textureId = textureRegistry.register(self)
        captureSession = AVCaptureSession()
        let position = openArguments.selector.facing == .back ? AVCaptureDevice.Position.back : .front
        if #available(iOS 10.0, *) {
            device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position).devices.first
        } else {
            device = AVCaptureDevice.devices(for: .video).filter({$0.position == position}).first
        }
        device.addObserver(self, forKeyPath: #keyPath(AVCaptureDevice.torchMode), options: .new, context: nil)
        captureSession.beginConfiguration()
        // Add device input.
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureSession.addInput(input)
        } catch {
            error.throwToFlutter(result)
        }
        // Add video output.
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        captureSession.addOutput(videoOutput)
        for connection in videoOutput.connections {
            connection.videoOrientation = .portrait
            if position == .front && connection.isVideoMirroringSupported {
                connection.isVideoMirrored = true
            }
        }
        captureSession.commitConfiguration()
        captureSession.startRunning()
        let demensions = CMVideoFormatDescriptionGetDimensions(device.activeFormat.formatDescription)
        let width = Double(demensions.height)
        let height = Double(demensions.width)
        let size = ["width": width, "height": height]
        let answer: [String : Any?] = ["textureId": textureId, "size": size, "torchable": device.hasTorch]
        result(answer)
    }
    
    func close(_ key:String, _ result: FlutterResult) {
        captureSession.stopRunning()
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }
        device.removeObserver(self, forKeyPath: #keyPath(AVCaptureDevice.torchMode))
        textureRegistry.unregisterTexture(textureId)
        
        latestBuffer = nil
        captureSession = nil
        device = nil
        textureId = nil
        
        result(nil)
    }
    
    func torch(_ key:String, _ state: Bool, _ result: @escaping FlutterResult) {
        do {
            try device.lockForConfiguration()
            device.torchMode = state ? .on : .off
            device.unlockForConfiguration()
            result(nil)
        } catch {
            error.throwToFlutter(result)
        }
    }
    
    func zoom(_ key: String, _ value: Double, _ result: @escaping FlutterResult) {
        device.videoZoomFactor = value
        result(nil)
    }
    
    func closeImageProxy(_ key:String,_ result:FlutterResult) {
        
    }
    
    public func copyPixelBuffer() -> Unmanaged<CVPixelBuffer>? {
        if latestBuffer == nil {
            return nil
        }
        return Unmanaged<CVPixelBuffer>.passRetained(latestBuffer)
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        latestBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        textureRegistry.textureFrameAvailable(textureId)
        
        switch analyzeMode {
        case 1: // barcode
            if analyzing {
                break
            }
            analyzing = true
            let buffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            let image = VisionImage(image: buffer!.image)
            let scanner = BarcodeScanner.barcodeScanner()
            scanner.process(image) { [self] barcodes, error in
                if error == nil && barcodes != nil {
                    for barcode in barcodes! {
                        let event: [String: Any?] = ["name": "barcode", "data": barcode.data]
                        sink?(event)
                    }
                }
                analyzing = false
            }
        default: // none
            break
        }
    }
    
    func stateNative(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            result(0)
        case .authorized:
            result(1)
        default:
            result(2)
        }
    }
    
    func requestNative(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { result($0) })
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "torchMode":
            // off = 0; on = 1; auto = 2;
            let state = change?[.newKey] as? Int
            let event: [String: Any?] = ["name": "torchState", "data": state]
            eventSink?(event)
        default:
            break
        }
    }
}

extension FlutterMethodCall {
    var command: Messages_Command {
        let typedArguments = arguments as! FlutterStandardTypedData
        return try! Messages_Command(serializedData: typedArguments.data)
    }
}

extension Error {
    func throwToFlutter(_ result: FlutterResult) {
        let error = FlutterError(code: localizedDescription, message: nil, details: nil)
        result(error)
    }
}
