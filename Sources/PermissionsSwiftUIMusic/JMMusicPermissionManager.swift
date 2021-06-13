//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/22/21.
//

import Foundation
import MediaPlayer

#if !os(tvOS)
struct JMMusicPermissionManager: PermissionManager{
    init(permissionType: PermissionType?) {}
    var authorizationStatus: AuthorizationStatus{
        switch MPMediaLibrary.authorizationStatus(){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        MPMediaLibrary.requestAuthorization {authStatus in
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
