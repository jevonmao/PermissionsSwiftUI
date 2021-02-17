//
//  JMCameraPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import AVFoundation
import Foundation

//Contributors: please see JMLocationPermissionManager.swift for code comments
struct JMCameraPermissionManager {
    static var shared = JMCameraPermissionManager()
    func requestPermission(completion: @escaping (Bool) -> Void?) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
            authorized in
            DispatchQueue.main.async {
                completion(authorized)
            }
        })
    }
}
