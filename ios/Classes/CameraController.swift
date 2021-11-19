//
//  NativeCamera.swift
//  camerax
//
//  Created by 闫守旺 on 2021/11/16.
//

import Foundation
import AVFoundation

class CameraController: NSObject, FlutterTexture {
    let key = UUID().uuidString
    let textureRegistry: FlutterTextureRegistry
    let openArguments: OpenArguments
    
    
    init(_ textureRegistry: FlutterTextureRegistry, _ openArguments: OpenArguments) {
        self.textureRegistry = textureRegistry
        self.openArguments = openArguments
    }
    
    func copyPixelBuffer() -> Unmanaged<CVPixelBuffer>? {
        <#code#>
    }
}
