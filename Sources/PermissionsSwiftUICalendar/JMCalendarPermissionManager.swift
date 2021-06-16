//
//  JMCalendarPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import UIKit
#if !os(tvOS)
import EventKit
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    static let calendar = JMCalendarPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMCalendarPermissionManager: PermissionType.PermissionManager {
    
    
    public override var permissionType: PermissionType {
        .calendar
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch EKEventStore.authorizationStatus(for: .event){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted, error)
            }
        })
    }
}
#endif
