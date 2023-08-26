//
//  JMTrackingPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import AppTrackingTransparency
import AdSupport
import CorePermissionsSwiftUI

@available(iOS 14, tvOS 14, *)
public extension PermissionManager {
    ///In order for app to track user's data across apps and websites, the tracking permission is needed
    static let tracking = JMTrackingPermissionManager()
}

@available(iOS 14, tvOS 14, *)
public class JMTrackingPermissionManager: PermissionManager {
    public override var permissionType: PermissionType {
        get {
                .tracking
        }
    }
    
    override public var authorizationStatus: AuthorizationStatus {
        switch ATTrackingManager.trackingAuthorizationStatus{
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    public static var advertisingIdentifier:UUID{
        ASIdentifierManager.shared().advertisingIdentifier
    }
    
    
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
                  switch status {
                  case .authorized:
                      completion(true, nil)
                  case .notDetermined:
                      break
                  default:
                      completion(false, nil)
                  }
              }
    }
}
