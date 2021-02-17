//
//  JMTrackingPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import AppTrackingTransparency
import AdSupport

//Contributors: please see JMLocationPermissionManager.swift for code comments
@available(iOS 14.5, *)
struct JMTrackingPermissionManager {
    static var shared = JMTrackingPermissionManager()
    public static var advertisingIdentifier:UUID{
        ASIdentifierManager.shared().advertisingIdentifier
    }
    func requestPermission(completion: @escaping (Bool) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
                  switch status {
                  case .authorized:
                      completion(true)
                  case .notDetermined:
                      break
                  default:
                      completion(false)
                  }
              }
    }
}
