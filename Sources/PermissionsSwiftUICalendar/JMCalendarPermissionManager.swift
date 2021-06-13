//
//  JMCalendarPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import UIKit
#if !os(tvOS)
import EventKit

struct JMCalendarPermissionManager: PermissionType.PermissionManager {  
    internal init() { super.init() }
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
    init(){}

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
