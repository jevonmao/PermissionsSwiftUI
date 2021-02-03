//
//  JMTrackingPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import AppTrackingTransparency
import AdSupport

@available(iOS 14, *)
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
