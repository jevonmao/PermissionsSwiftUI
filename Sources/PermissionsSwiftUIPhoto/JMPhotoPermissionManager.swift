//
//  JMPhotoPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import Photos
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///Used to access the user's photo library before iOS 14
    @available(iOS, deprecated, obsoleted: 100000, message: "Use 'authorizationStatus(for: )' instead after iOS 14.0.")
    static let photo = JMPhotoPermissionManager(requestedAccessLevel: .legacy)
    
    ///Used to read-only access the user's photo library
    @available(iOS 14.0, *)
    static let photoRead = JMPhotoPermissionManager(requestedAccessLevel: .writeOnly)
    
    ///Used to read and write to the user's photo library
    @available(iOS 14.0, *)
    static let photoFull = JMPhotoPermissionManager(requestedAccessLevel: .full)
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMPhotoPermissionManager: PermissionManager {
    public init(requestedAccessLevel: AccessLevel = .legacy) {
        self.requestedAccessLevel = requestedAccessLevel
        if requestedAccessLevel == .legacy {
            NSLog("[PermissionsSwiftUI]: WARNING! Using legacy calendar or reminder permission, which will NOT work in iOS 17 and always return denied due to Apple EventKit API changes. Learn more: https://developer.apple.com/documentation/eventkit/accessing_the_event_store")
        }
    }
    public var requestedAccessLevel: AccessLevel

    public enum AccessLevel {
        case legacy
        @available(iOS 14, *) case writeOnly
        @available(iOS 14, *) case full
    }

    public override var permissionType: PermissionType {
        .photo
    }

    public override var authorizationStatus: AuthorizationStatus  {
        var result: PHAuthorizationStatus? = nil
        switch requestedAccessLevel {
        case .legacy:
            result = PHPhotoLibrary.authorizationStatus()
        case .full:
            if #available(iOS 14, *) {
                result = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            }
        case .writeOnly:
            if #available(iOS 14, *) {
                result = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            }
        }
        switch result {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        case .limited:
            return .limited
        default:
            return .denied
        }
    }

    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        switch requestedAccessLevel {
        case .legacy:
            PHPhotoLibrary.requestAuthorization { status in
                self.handleAuthorizationResult(status, completion: completion)
            }
        case .full:
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    self.handleAuthorizationResult(status, completion: completion)
                }
            }
        case .writeOnly:
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                    self.handleAuthorizationResult(status, completion: completion)
                }
            }
        default:
            completion(false, nil)
        }
    }

    private func handleAuthorizationResult(_ status: PHAuthorizationStatus, completion: @escaping (Bool, Error?) -> Void) {
        switch status {
        case .authorized, .limited:
            completion(true, nil)
        default:
            completion(false, nil)
        }
    }

}

