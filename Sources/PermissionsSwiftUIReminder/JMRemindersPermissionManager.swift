//
//  JMRemindersPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
#if !os(tvOS)
import EventKit
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    ///Permission that allows app to read & write to device reminder before iOS 17
    @available(tvOS, unavailable, deprecated: 16.0, obsoleted: 17.0, message: "iOS 17.0 introduced breaking changes to calendar and reminder permissions. Use the new PermissionTypes that specifies level of permission.")
    static let reminders = JMRemindersPermissionManager(requestedAccessLevel: .legacy)

    ///Permission that allows app to read & write to device reminder
    @available(tvOS, unavailable)
    static let remindersFull = JMRemindersPermissionManager(requestedAccessLevel: .full)
}
@available(iOS 13.0, tvOS 13.0, *)
public final class JMRemindersPermissionManager: PermissionType.PermissionManager {
    
    public init(requestedAccessLevel: AccessLevel) {
        self.requestedAccessLevel = requestedAccessLevel
    }


    public var requestedAccessLevel: AccessLevel

    public enum AccessLevel {
        case legacy, full
    }

    public override var permissionType: PermissionType {
        .reminders
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch EKEventStore.authorizationStatus(for: .reminder){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    public override func requestPermission(completion: @escaping (Bool, Error?)->()) {
        let eventStore = EKEventStore()
        if #available(iOS 17.0, *) {
            //Request for permission using new API
        }

        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted, error)
            }
        })
    }
}
#endif
