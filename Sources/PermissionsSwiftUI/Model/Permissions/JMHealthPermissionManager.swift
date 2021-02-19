//
//  JMHealthPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import Foundation
import HealthKit

class JMHealthPermissionManager{
    let healthStore = HKHealthStore()
    static let shared = JMHealthPermissionManager()
    typealias JMBluetoothPermissionHandler = (Bool) -> Void?

    func requestPermission(toShare: Set<HKSampleType>, read: Set<HKSampleType>, completion: @escaping (Bool) -> Void?) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("PermissionsSwiftUI - Health data is not available") 
            completion(false)
            return
        }
        healthStore.requestAuthorization(toShare: toShare, read: read) { authorized, error in

            guard error == nil else{
                print("PermissionSwiftUI - \(String(describing: error))")
                completion(false)
                return
            }
            completion(authorized)
        }
        
    }
    
}

