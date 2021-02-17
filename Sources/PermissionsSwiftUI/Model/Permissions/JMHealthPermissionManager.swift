//
//  JMHealthPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import Foundation
import HealthKit

//Contributors: please see JMLocationPermissionManager.swift for code comments
class JMHealthPermissionManager{
    let healthStore = HKHealthStore()
    static let shared = JMHealthPermissionManager()
    typealias JMBluetoothPermissionHandler = (Bool) -> Void?

    func requestPermission(for HKPermissions:Set<HKSampleType>, completion: @escaping (Bool) -> Void?) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("PermissionsSwiftUI - Health data is not available") 
            completion(false)
            return
        }
        healthStore.requestAuthorization(toShare: HKPermissions, read: HKPermissions){authorized, error in
            guard error == nil else{
                print("PermissionSwiftUI - \(String(describing: error))")
                completion(false)
                return
            }
            completion(authorized)
        }
        
    }
    
}

