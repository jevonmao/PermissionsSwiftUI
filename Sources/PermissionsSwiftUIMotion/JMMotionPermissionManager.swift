//
//  JMMotionPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
#if !os(tvOS)
import CoreMotion

struct JMMotionPermissionManager: PermissionType.PermissionManager { 
    
    typealias authorizationStatus = CMAuthorizationStatus
    typealias permissionManagerInstance = JMMotionPermissionManager
    internal init() { super.init() }
    public override var authorizationStatus: AuthorizationStatus  {
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        let manager = CMMotionActivityManager()
        let today = Date()
        
        manager.queryActivityStarting(from: today, to: today, to: OperationQueue.main, withHandler: { (activities: [CMMotionActivity]?, error: Error?) -> () in
            if error != nil{
                completion(false, error)
            }
            else{
                completion(true, nil)
            }
            manager.stopActivityUpdates()
        })
        
        
    }
}
#endif
