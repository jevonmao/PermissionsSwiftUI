//
//  JMMicPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import AVFoundation
import Foundation

struct JMMicPermissionManager {
    static var shared = JMMicPermissionManager()
    
    func requestPermission(completion: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        AVAudioSession.sharedInstance().requestRecordPermission {
            granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
}

extension JMMicPermissionManager {
    typealias JMPermissionAuthorizationHandlerCompletionBlock = (Bool) -> Void
}
