//
//  Util.swift
//  camerax
//
//  Created by 闫守旺 on 2021/2/6.
//
import AVFoundation

typealias Command = Messages_Command
typealias CommandCategory = Messages_CommandCategory
//typealias OpenArguments = Message
typealias CameraSelector = Messages_CameraSelector
typealias CameraFacing = Messages_CameraFacing
typealias CameraValue = Messages_CameraValue
//typealias TextureValue = Messages_TextureValue
typealias BindArguments = Messages_CameraControllerBindCommandArguments
typealias UnbindArguments = Messages_CameraControllerUnbindCommandArguments
typealias TorchArguments = Messages_CameraControllerTorchCommandArguments
typealias ZoomArguments = Messages_CameraControllerZoomCommandArguments
typealias QuarterTurnsArguments = Messages_GetQuarterTurnsReplyArguments
typealias ImageProxy = Messages_ImageProxy
typealias ImageProxyCloseArguments = Messages_ImageProxyCloseCommandArguments
typealias FocusAutomaticallyArguments = Messages_CameraControllerFocusAutomaticallyCommandArguments
typealias FocusManuallyArguments = Messages_CameraControllerFocusManuallyCommandArguments
typealias Event = Messages_Event
typealias EventCategory = Messages_EventCategory
typealias EventImageProxyArguments = Messages_CameraControllerImageProxiedEventArguments

typealias PermissionReplyArguments = Messages_CameraControllerRequestPermissionReplyArguments

extension CVBuffer {
    var image: UIImage {
        let ciImage = CIImage(cvPixelBuffer: self)
        let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)
        return UIImage(cgImage: cgImage!)
    }
    
    var image1: UIImage {
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags.readOnly)
        // Get the number of bytes per row for the pixel buffer
        let baseAddress = CVPixelBufferGetBaseAddress(self)
        // Get the number of bytes per row for the pixel buffer
        let bytesPerRow = CVPixelBufferGetBytesPerRow(self)
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        // Create a device-dependent RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // Create a bitmap graphics context with the sample buffer data
        var bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        //let bitmapInfo: UInt32 = CGBitmapInfo.alphaInfoMask.rawValue
        let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        // Create a Quartz image from the pixel data in the bitmap graphics context
        let quartzImage = context?.makeImage()
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags.readOnly)
        // Create an image object from the Quartz image
        return  UIImage(cgImage: quartzImage!)
    }
}

extension UIDeviceOrientation {
    func imageOrientation(position: AVCaptureDevice.Position) -> UIImage.Orientation {
        switch self {
        case .portrait:
            return position == .front ? .leftMirrored : .right
        case .landscapeLeft:
            return position == .front ? .downMirrored : .up
        case .portraitUpsideDown:
            return position == .front ? .rightMirrored : .left
        case .landscapeRight:
            return position == .front ? .upMirrored : .down
        default:
            return .up
        }
    }
}
