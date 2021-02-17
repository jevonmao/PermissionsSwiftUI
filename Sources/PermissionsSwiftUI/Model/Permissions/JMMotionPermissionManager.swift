//
//  JMMotionPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import CoreMotion

//Contributors: please see JMLocationPermissionManager.swift for code comments
struct JMMotionPermissionManager {
    static let shared = JMMotionPermissionManager()
    var isAuthorized: Bool {
        return CMMotionActivityManager.authorizationStatus() == .authorized
    }
    func requestPermission(completion: @escaping (Bool)->()) {
        if !isAuthorized{
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
        else{
            completion(true)
        }
       
    }
}
