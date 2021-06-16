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
public extension PermissionType.PermissionManager {
    static func health(categories: HKAccess) -> JMHealthPermissionManager {
        JMHealthPermissionManager(categories: categories)
    }
}

@available(iOS 13.0, tvOS 13.0, *)
public class JMHealthPermissionManager: PermissionType.PermissionManager {
    
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
    public override var authorizationStatus: AuthorizationStatus {
        get {
            //Count to track total # of permissions allowed and denied each
            var allowDenyCount: CountComparison = (authorized: 0, denied: 0)
            var status: AuthorizationStatus {
                //Set to notDetermined if all permissions are not determined
                if allowDenyCount.0 == 0 && allowDenyCount.1 == 0 {
                    return .notDetermined
                }
                //Set to authorized if majority are authorized
                if allowDenyCount.0 > allowDenyCount.1 {
                    return .authorized
                }
                //Set to denied if majority are denied, or equal # of allowed and denied
                return .denied
            }
            
            /**
             - Note: From Apple Developer Documentation: "to help prevent possible leaks of sensitive health information, your app cannot determine whether or not a user has granted permission to read data. If you are not given permission, it simply appears as if there is no data of the requested type in the HealthKit store."
             */
            
            var readPermissions = categories.readPermissions
            var writePermissions = categories.writePermissions
            //Map the authorization status, remove allowed and denied permissions from array.
            //Increase allowDenyCount as needed.
            mapPermissionAuthorizationStatus(for: &readPermissions, forCount: &allowDenyCount)
            mapPermissionAuthorizationStatus(for: &writePermissions, forCount: &allowDenyCount)
            return status
        }

    }
    func mapPermissionAuthorizationStatus(for permissions: inout Set<HKSampleType>,
                                        forCount allowDenyCount: inout CountComparison) {
        for sampleType in permissions {
            switch healthStore.authorizationStatus(for: sampleType){
            case .sharingAuthorized:
                permissions.remove(sampleType)
                allowDenyCount.0 += 1
            case .sharingDenied:
                permissions.remove(sampleType)
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
