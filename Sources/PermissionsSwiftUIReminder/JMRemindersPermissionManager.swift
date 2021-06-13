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
    static let reminders = JMRemindersPermissionManager()
}
@available(iOS 13.0, tvOS 13.0, *)
public final class JMRemindersPermissionManager: PermissionType.PermissionManager {
    internal init() { super.init() }
    
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

    func requestPermission(_ completion: @escaping (Bool, Error?)->()) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted, error)
            }
        })
    }
}
#endif
