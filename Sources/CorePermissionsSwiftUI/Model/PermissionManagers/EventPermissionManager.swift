//
//  EventPermissionManager.swift
//  PermissionsSwiftUI-Example
//
//  Created by Jevon Mao on 8/26/23.
//

import Foundation
import EventKit

open class EventPermissionManager: PermissionManager {
    public init(requestedAccessLevel: AccessLevel = .legacy) {
        self.requestedAccessLevel = requestedAccessLevel
    }


    public var requestedAccessLevel: AccessLevel
    public let eventStore = EKEventStore()
    open var entityType: EKEntityType {
        get {
            preconditionFailure("This property must be overridden.")
        }
    }

    public enum AccessLevel {
        case writeOnly
        case full
        case legacy
    }

    public override var authorizationStatus: AuthorizationStatus {
        switch EKEventStore.authorizationStatus(for: entityType){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    public func requestLegacyPermission( _ completion: @escaping (Bool, Error?) -> Void) {
        eventStore.requestAccess(to: entityType, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted, error)
            }
        })
    }

}
