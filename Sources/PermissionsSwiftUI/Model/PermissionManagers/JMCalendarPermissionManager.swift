//
//  JMCalendarPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import EventKit
import UIKit

struct JMCalendarPermissionManager: PermissionManager {  
    
    static let shared: PermissionManager = JMCalendarPermissionManager()
    var authorizationStatus: AuthorizationStatus{
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

    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted, error)
            }
        })
    }
}
