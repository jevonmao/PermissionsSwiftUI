//
//  JMCameraPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//
#if os(iOS)
import AVFoundation
import Foundation
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///Permission that allows developers to interact with on-device camera
    static let camera = JMCameraPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMCameraPermissionManager: PermissionManager {
    
    
    public override var permissionType: PermissionType {
        .camera
    }
    
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
