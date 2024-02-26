//
//  JMRemindersPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import PermissionsSwiftUIEvent

#if !os(tvOS)
import EventKit
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///Permission that allows app to read & write to device reminder before iOS 17
    @available(tvOS, unavailable)
    @available(iOS, deprecated, obsoleted: 17.0, message: "iOS 17.0 introduced breaking changes to EventKit APIs. Learn more at https://developer.apple.com/documentation/eventkit/accessing_the_event_store.", renamed: "remindersFull")
    static let reminders = JMRemindersPermissionManager(requestedAccessLevel: .legacy)

    ///Permission that allows app to read & write to device reminder
    @available(tvOS, unavailable)
    static let remindersFull = JMRemindersPermissionManager(requestedAccessLevel: .full)
}
@available(iOS 13.0, tvOS 13.0, *)
public final class JMRemindersPermissionManager: EventPermissionManager {
    public override var permissionType: PermissionType {
        .reminders
    }

    public override var entityType: EKEntityType {
        .reminder
    }

    public override func requestPermission(completion: @escaping (Bool, Error?)->()) {
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToReminders(completion: completion)
        }
        else {
            requestLegacyPermission(completion)
        }
    }
}
#endif
