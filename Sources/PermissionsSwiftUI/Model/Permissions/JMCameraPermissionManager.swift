//
//  JMCameraPermissionManager.swift
//  
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import AVFoundation

struct JMCameraPermissionManager {
    
    static var shared = JMCameraPermissionManager()
    
    func requestPermission(completion: @escaping (Bool)->()?) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
            authorized in
            DispatchQueue.main.async {
                completion(authorized)
            }
        })
    }
}
