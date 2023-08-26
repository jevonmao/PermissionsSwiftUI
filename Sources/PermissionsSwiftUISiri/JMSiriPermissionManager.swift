//
//  JMSiriPermissionManager.swift
//  
//
//  Created by Jevon Mao on 6/14/21.
//

import Foundation
import CorePermissionsSwiftUI
import Intents

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///Permission that allows Siri and Maps to communicate with your app
    static let siri = JMSiriPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMSiriPermissionManager: PermissionManager {
    
    
    public override var permissionType: PermissionType {
            .siri
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch INPreferences.siriAuthorizationStatus() {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        INPreferences.requestSiriAuthorization {authorizationStatus in
            if authorizationStatus == .authorized {
                completion(true, nil)
            }
            else {
                completion(false, nil)
            }
        }
    }
}
