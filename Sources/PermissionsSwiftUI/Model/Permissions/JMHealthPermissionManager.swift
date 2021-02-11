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

    func requestPermission(completion: @escaping (Bool) -> Void?) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("PermissionsSwiftUI - Health data is not available")
            completion(false)
            return
        }
        let allTypes = Set([HKObjectType.workoutType(), HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!])
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes){authorized, error in
            guard error == nil else{
                print("PermissionSwiftUI - \(String(describing: error))")
                completion(false)
                return
            }
            completion(authorized)
        }
        
    }
    
}

