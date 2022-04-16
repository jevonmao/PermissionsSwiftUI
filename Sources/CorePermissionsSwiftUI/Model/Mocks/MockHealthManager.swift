//
//  MockHealthManager.swift.swift
//  
//
//  Created by Jevon Mao on 2/25/21.
//

import Foundation
#if !os(tvOS) && PERMISSIONSWIFTUI_HEALTH
import HealthKit
protocol HealthManager {
    func authorizationStatus(for type: HKObjectType) -> HKAuthorizationStatus
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void)
    static func isHealthDataAvailable() -> Bool

}
extension HKHealthStore: HealthManager {}

final class MockHealthManager: HealthManager {
    enum AuthorizationStatus: CaseIterable {
        case notDetermined, authorized, denied, mixedAuthorized, mixedDenied
    }
    var authStatusOverride: AuthorizationStatus = .notDetermined
    var requestSuccessOverride: Bool = true
    static var healthDataAvailableOverride: Bool = true
    
    var requestedPermissions: HKAccess?
    var lastStatus: HKAuthorizationStatus = .notDetermined
    func authorizationStatus(for type: HKObjectType) -> HKAuthorizationStatus {
        switch authStatusOverride {
        case .authorized:
            return .sharingAuthorized
        case .notDetermined:
            return .notDetermined
        case .denied:
            return .sharingDenied
        case .mixedAuthorized:
            return getCorrectPermission()
        case .mixedDenied:
            return getCorrectPermission()
        }
        
    }
    
    func getCorrectPermission() -> HKAuthorizationStatus {
        var keyStatus: HKAuthorizationStatus = .sharingAuthorized
        if self.authStatusOverride == .mixedDenied {
            keyStatus = .sharingDenied
        }
        if lastStatus == .notDetermined {
            self.lastStatus = keyStatus
            return keyStatus
        } else {
            self.lastStatus = .notDetermined
            return .notDetermined
        }
    }
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void) {
        let healthDataAvailable = MockHealthManager.healthDataAvailableOverride
        if requestSuccessOverride {
            completion(requestSuccessOverride, healthDataAvailable ? nil : fatalError("MockHealthManager - health data is not available"))
            guard typesToShare != nil || typesToRead != nil else {return}
            if let typesToShare = typesToShare, let typesToRead = typesToRead {
                requestedPermissions = .init(read: typesToRead as! Set<HKSampleType>, write: typesToShare)
            } else if let typesToShare = typesToShare {
                requestedPermissions = .init(write: typesToShare)
            } else if let typesToRead = typesToRead {
                requestedPermissions = .init(read: typesToRead as! Set<HKSampleType>)
            }
        }
        else {
            completion(false, NSError(domain: "", code: 0, userInfo: nil))
        }
    }
    
    static func isHealthDataAvailable() -> Bool {
        healthDataAvailableOverride
    }
    
    
}
#endif
