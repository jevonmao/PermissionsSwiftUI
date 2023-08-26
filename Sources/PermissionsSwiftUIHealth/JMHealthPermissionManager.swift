//
//  JMHealthPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import Foundation
#if !os(tvOS) && PERMISSIONSWIFTUI_HEALTH
import CorePermissionsSwiftUI
import HealthKit

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    /**
     Permission that allows app to access healthkit information
     
     - Note: Extensive Info.plist  values and configurations are required for HealthKit authorization. Please see Apple Developer [website](https://developer.apple.com/documentation/healthkit/authorizing_access_to_health_data) for details. \n
     
     For example, passing in a `Set` of `HKSampleType`:
     ```
     [.health(categories: .init(readAndWrite: Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])))]
     ```
     
     - Attention: From Apple Developer Documentation: "to help prevent possible leaks of sensitive health information, your app cannot determine whether or not a user has granted permission to read data. If you are not given permission, it simply appears as if there is no data of the requested type in the HealthKit store."
     */
    static func health(categories: HKAccess) -> JMHealthPermissionManager {
        JMHealthPermissionManager(categories: categories)
    }
}

@available(iOS 13.0, tvOS 13.0, *)
public class JMHealthPermissionManager: PermissionManager {
    
    typealias authorizationStatus = HKAuthorizationStatus
    typealias CountComparison = (Int, Int)
    var categories: HKAccess
    let healthStore = HKHealthStore()
    override public var permissionType: PermissionType {
        get {
            .health
        }
    }

    init(categories: HKAccess) {
        self.categories = categories
    }
    
    /**
     - Note: From Apple Developer Documentation: "to help prevent possible leaks of sensitive health information, your app cannot determine whether or not a user has granted permission to read data. If you are not given permission, it simply appears as if there is no data of the requested type in the HealthKit store."
     */
    public override var authorizationStatus: AuthorizationStatus {
        get {
            var allowDenyCount: CountComparison = (authorized: 0, denied: 0)  //Tracks # of authorized and denied health categories
            var status: AuthorizationStatus {
                
                //Set to notDetermined if all permissions are not determined
                if allowDenyCount.0 == 0 && allowDenyCount.1 == 0 {
                    return .notDetermined
                }
                
                //Set to authorized if at least 1 type is authorized
                if allowDenyCount.0 > 0 {
                    return .authorized
                }
                
                //If all types are denied, set status to denied
                else {
                    return .denied
                }
            }
            
            //Map the authorization status, remove allowed and denied permissions from array.
            //Increase allowDenyCount as needed.
            mapPermissionAuthorizationStatus(for: categories.writePermissions, forCount: &allowDenyCount)
            
            //Assume all read permissions are authorized, because Apple restrict app from determining read data
            if categories.writePermissions.isEmpty {
                allowDenyCount.0 += categories.readPermissions.count
            }
            return status
        }

    }
    func mapPermissionAuthorizationStatus(for permissions: Set<HKSampleType>,
                                        forCount allowDenyCount: inout CountComparison) {
        for sampleType in permissions {
            switch healthStore.authorizationStatus(for: sampleType){
            case .sharingAuthorized:
                allowDenyCount.0 += 1
            case .sharingDenied:
                allowDenyCount.1 += 1
            default:
                ()
            }
        }
    }
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            #if DEBUG
            print("PermissionsSwiftUI - Health data is not available")
            #endif
            completion(false, createUnavailableError())
            return
        }
        healthStore.requestAuthorization(toShare: Set(categories.writePermissions),
                                         read: Set(categories.readPermissions)) { authorized, error in
            completion(self.authorizationStatus == .authorized, error)
        }
        
    }
    func createUnavailableError() -> NSError {
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey:
              NSLocalizedString("Health permission request couldn't be completed.",
                                comment: "localizedErrorDescription"),
            NSLocalizedFailureReasonErrorKey:
                NSLocalizedString("Health data is not available on the current device, the permission cannot be requested.", 
                                  comment: "localizedErrorFailureReason"),
            NSLocalizedRecoverySuggestionErrorKey:
              NSLocalizedString("Verify that HealthKit is available on the current device.",
                                comment: "localizedErrorRecoverSuggestion")
          ]
        return NSError(domain: "com.jevonmao.permissionsswiftui", code: 1, userInfo: userInfo)
    }
}
#endif
