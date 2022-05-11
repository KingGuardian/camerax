import AVFoundation
import Flutter
import Messages

public class SwiftCameraXPlugin: NSObject, FlutterPlugin {
    static let namespace = "yanshouwang.dev/camerax"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let binaryMessenger = registrar.messenger()
        //注册camera controller 的相关channel
        let methodHandler = CameraXMethodHandler.init(registrar: registrar)
        let methodChannel = FlutterMethodChannel(name: "\(namespace)/method", binaryMessenger: binaryMessenger)
        registrar.addMethodCallDelegate(methodHandler, channel: methodChannel)
        
        //注册camerax的事件回调
        let eventChannel = FlutterEventChannel(name: "\(namespace)/event", binaryMessenger: binaryMessenger)
        eventChannel.setStreamHandler(eventHandler)
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
