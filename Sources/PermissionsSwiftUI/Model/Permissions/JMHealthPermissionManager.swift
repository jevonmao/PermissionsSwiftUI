//
//  JMHealthPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import Foundation
import HealthKit

class JMHealthPermissionManager: PermissionManager{
    
    typealias authorizationStatus = HKAuthorizationStatus
    typealias permissionManagerInstance = JMHealthPermissionManager
    
    let healthStore = HKHealthStore()
    static let shared: PermissionManager = JMHealthPermissionManager()
    
    //Get the health permission from stored permissions array
    let healthPermission = PermissionStore.shared.permissions.first(where: {
        if case .health = $0{
            return true
        }
        return false
    })
    var writePermissions:Array<HKSampleType>{
        //toShare is permission to write health record
        if case .health(let toShare, _) = healthPermission{
            return Array(toShare)
        }
        return []
    }
    var readPermissions:Array<HKSampleType>{
        //read is permission to read health record
        if case .health(_, let read) = healthPermission{
            return Array(read)
        }
        return []
    }
    var authorizationStatus: AuthorizationStatus{
        var defaultStatus = AuthorizationStatus.notDetermined
        /**
        Iterating over writePermissions.
         - Note: From Apple Developer Documentation: "to help prevent possible leaks of sensitive health information, your app cannot determine whether or not a user has granted permission to read data. If you are not given permission, it simply appears as if there is no data of the requested type in the HealthKit store."
         */
        _ = writePermissions.map {
            switch healthStore.authorizationStatus(for: $0){ 
            case .sharingAuthorized:
                defaultStatus = .authorized
            //Instantly break out of loop and set status to denied
            case .sharingDenied:
                defaultStatus = .denied
                break
            default:
                ()
            }
        }
        
        return defaultStatus
    }
    
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("PermissionsSwiftUI - Health data is not available")
            completion(false)
            return
        }
        healthStore.requestAuthorization(toShare: Set(writePermissions), read: Set(readPermissions)) { authorized, error in
            
            guard error == nil else{
                print("PermissionSwiftUI - \(String(describing: error))")
                completion(false)
                return
            }
            completion(true)
        }
        
    }
}


