//
//  JMMotionPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import CoreMotion

struct JMMotionPermissionManager: PermissionManager {
    
    typealias authorizationStatus = CMAuthorizationStatus
    typealias permissionManagerInstance = JMMotionPermissionManager
    
    static let shared: PermissionManager = JMMotionPermissionManager()
    var authorizationStatus: AuthorizationStatus {
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        let manager = CMMotionActivityManager()
        let today = Date()
        
        manager.queryActivityStarting(from: today, to: today, to: OperationQueue.main, withHandler: { (activities: [CMMotionActivity]?, error: Error?) -> () in
            if error != nil{
                completion(false)
            }
            else{
                completion(true)
            }
            manager.stopActivityUpdates()
        })
        
        
    }
}
