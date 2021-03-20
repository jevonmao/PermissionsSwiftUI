//
//  JMPhotoPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import Photos

struct JMPhotoPermissionManager: PermissionManager {
    
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
    var photoLibrary: PHPhotoLibrary.Type
    init(photoLibrary:PHPhotoLibrary.Type=PHPhotoLibrary.self){
        self.photoLibrary = photoLibrary
    }
    init(permissionType: PermissionType?=nil){
        self.init(photoLibrary: PHPhotoLibrary.self)
    }

    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        photoLibrary.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                completion(true, nil)
            case .limited:
                completion(true, nil)
            default:
                completion(false, nil)
            }
        }
    }
}

