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
    ///Permission that allows app to read & write to device calenda
    @available(tvOS, unavailable)
    static let calendarFull = JMCalendarPermissionManager(requestedAccessLevel: .full)

    ///Permission that allows app to only write to device calendar
    @available(tvOS, unavailable)
    static let calenderWrite = JMCalendarPermissionManager(requestedAccessLevel: .writeOnly)

    ///Permission that allows app to read & write to device calendar before iOS 17
    @available(tvOS, unavailable, deprecated: 16.0, obsoleted: 17.0, message: "iOS 17.0 introduced breaking changes to calendar and reminder permissions. Use the new PermissionTypes that specifies level of permission.")
    static let calendar = JMCalendarPermissionManager(requestedAccessLevel: .legacy)
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMCalendarPermissionManager: PermissionType.PermissionManager {
    public init(requestedAccessLevel: AccessLevel) {
        self.requestedAccessLevel = requestedAccessLevel
    }


    public var requestedAccessLevel: AccessLevel

    public enum AccessLevel {
        case writeOnly, full, legacy
    }
    
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
        switch requestedAccessLevel {
        case .legacy:
            eventStore.requestAccess(to: EKEntityType.event, completion: {
                (accessGranted: Bool, error: Error?) in
                DispatchQueue.main.async {
                    completion(accessGranted, error)
                }
            })
        case .full:
            // request using new API
            break
        case .writeOnly:
            // request using new API
            break
        }

    }
}
#endif
