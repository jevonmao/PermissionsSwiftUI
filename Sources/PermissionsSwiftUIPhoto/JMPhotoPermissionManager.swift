//
//  JMPhotoPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import Photos
import PermissionsSwiftUIInternal

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    static let photo = JMPhotoPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public class JMPhotoPermissionManager: PermissionType.PermissionManager {
    internal init() { super.init() }
    
    public override var permissionType: PermissionType {
        .photo
    }
    
    public override var authorizationStatus: AuthorizationStatus  {
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
    
    var photoLibrary: PHPhotoLibrary.Type = PHPhotoLibrary.self
    init(photoLibrary:PHPhotoLibrary.Type=PHPhotoLibrary.self){
        self.photoLibrary = photoLibrary
    }
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
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

