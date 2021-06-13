//
//  JMCameraPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//
#if os(iOS)
import AVFoundation
import Foundation

struct JMCameraPermissionManager: PermissionType.PermissionManager {
    internal init() { super.init() }
    public override var authorizationStatus: AuthorizationStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
            authorized in
            DispatchQueue.main.async {
                completion(authorized, nil)
            }
        })
    }
}
#endif
