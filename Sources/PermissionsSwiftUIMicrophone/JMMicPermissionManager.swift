//
//  JMMicPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//
#if os(iOS)
import AVFoundation
import Foundation
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    static let microphone = JMMicrophonePermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMMicrophonePermissionManager: PermissionType.PermissionManager {
    public override var permissionType: PermissionType {
        .microphone
    }
    public override var authorizationStatus: AuthorizationStatus {
        switch AVCaptureDevice.authorizationStatus(for: .audio){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    internal init() { super.init() }
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission {
            granted in
            DispatchQueue.main.async {
                completion(granted, nil)
            }
        }
    }
}
#endif
