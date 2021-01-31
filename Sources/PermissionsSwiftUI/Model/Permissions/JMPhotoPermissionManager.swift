//
//  JMPhotoPermissionManager.swift
//  
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import Photos

struct JMPhotoPermissionManager {
    
    static var shared = JMPhotoPermissionManager()
    
    func requestPermission(completion: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        PHPhotoLibrary.requestAuthorization{authStatus in
            switch authStatus{
            case .authorized:
                completion(true)
            case .limited:
                completion(true)
            default:
                completion(false)
            }
        }
    }
}
extension JMPhotoPermissionManager {
    
    typealias JMPermissionAuthorizationHandlerCompletionBlock = (Bool) -> Void
}
