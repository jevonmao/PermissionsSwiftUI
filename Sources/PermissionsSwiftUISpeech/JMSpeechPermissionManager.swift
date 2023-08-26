//
//  JMSpeechPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
#if !os(tvOS)
import Speech
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///Permission that allows app to use speech recognition
    static let speech = JMSpeechPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMSpeechPermissionManager: PermissionManager {
    
    
    public override var permissionType: PermissionType {
        .speech
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch SFSpeechRecognizer.authorizationStatus(){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        SFSpeechRecognizer.requestAuthorization {authStatus in
            switch authStatus{
            case .authorized:
                completion(true, nil)
            case .notDetermined:
                break
            default:
                completion(false, nil)
            }
        }
    }
}
#endif
