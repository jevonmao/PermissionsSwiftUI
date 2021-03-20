//
//  JMMicPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import AVFoundation
import Foundation

struct JMMicrophonePermissionManager: PermissionManager {  
    
    init(permissionType: PermissionType?=nil){}
    var authorizationStatus: AuthorizationStatus{
        switch AVCaptureDevice.authorizationStatus(for: .audio){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    //init(){}
    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission {
            granted in
            DispatchQueue.main.async {
                completion(granted, nil)
            }
        }
    }
}
