//
//  JMSpeechPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
#if !os(tvOS)
import Speech
import PermissionsSwiftUIInternal

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    static let speech = JMSpeechPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public class JMSpeechPermissionManager: PermissionType.PermissionManager {
    internal init() { super.init() }
    
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
