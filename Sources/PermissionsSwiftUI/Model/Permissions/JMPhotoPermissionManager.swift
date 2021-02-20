//
//  JMPhotoPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import Photos

struct JMPhotoPermissionManager: PermissionManager {
    
    static var shared: PermissionManager = JMPhotoPermissionManager()
    var photoLibrary:PHPhotoLibrary.Type
    
    init(photoLibrary:PHPhotoLibrary.Type=PHPhotoLibrary.self){
        self.photoLibrary = photoLibrary
    }
    
    var authorizationStatus: AuthorizationStatus {
        switch PHPhotoLibrary.authorizationStatus(){
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
    
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        photoLibrary.requestAuthorization { authStatus in
            switch authStatus {
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

