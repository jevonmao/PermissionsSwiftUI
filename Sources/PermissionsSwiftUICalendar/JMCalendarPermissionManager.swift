//
//  JMCalendarPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import PermissionsSwiftUIEvent

#if !os(tvOS)
import EventKit
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///Permission that allows app to read & write to device calendar
    @available(tvOS, unavailable)
    static let calendarFull = JMCalendarPermissionManager(requestedAccessLevel: .full)

    ///Permission that allows app to only write to device calendar
    @available(tvOS, unavailable)
    static let calenderWrite = JMCalendarPermissionManager(requestedAccessLevel: .writeOnly)

    ///Permission that allows app to read & write to device calendar before iOS 17
    @available(tvOS, unavailable)
    @available(iOS, deprecated, obsoleted: 17.0, message: "iOS 17.0 introduced breaking changes to EventKit APIs, use 'calendarFull' or 'calendarWrite' instead. Learn more at https://developer.apple.com/documentation/eventkit/accessing_the_event_store.")
    static let calendar = JMCalendarPermissionManager(requestedAccessLevel: .legacy)
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMCalendarPermissionManager: EventPermissionManager {
    public override var permissionType: PermissionType {
        .calendar
    }

    public override var entityType: EKEntityType {
        .event
    }

    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        switch requestedAccessLevel {
        case .legacy:
            requestLegacyPermission(completion)
        case .full:
            if #available(iOS 17.0, *) {
                eventStore.requestFullAccessToEvents{(success, error) in
                    DispatchQueue.main.async {
                        completion(success, error)
                    }

                }
            } else {
                requestLegacyPermission(completion)
            }
        case .writeOnly:
            if #available(iOS 17.0, *) {
                eventStore.requestWriteOnlyAccessToEvents {(success, error) in
                    DispatchQueue.main.async {
                        completion(success, error)
                    }
                }
            } else {
                requestLegacyPermission(completion)
            }
        }
    }
}
#endif
