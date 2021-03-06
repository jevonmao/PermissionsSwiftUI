//
//  JMCameraPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import AVFoundation
import Foundation

struct JMCameraPermissionManager: PermissionManager {

    var authorizationStatus: AuthorizationStatus{
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    static var shared: PermissionManager = JMCameraPermissionManager()
    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
            authorized in
            DispatchQueue.main.async {
                completion(authorized, nil)
            }
        })
    }
}
