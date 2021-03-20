//
//  JMSpeechPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import Speech

struct JMSpeechPermissionManager: PermissionManager{
    
    static let shared: PermissionManager = JMSpeechPermissionManager()
    var authorizationStatus: AuthorizationStatus{
        switch SFSpeechRecognizer.authorizationStatus(){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    init(permissionType: PermissionType?=nil){}

    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
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
