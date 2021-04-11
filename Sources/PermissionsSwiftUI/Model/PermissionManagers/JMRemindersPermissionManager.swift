//
//  JMRemindersPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
#if !os(tvOS)
import EventKit

struct JMRemindersPermissionManager: PermissionManager{
    
    var authorizationStatus: AuthorizationStatus{
        switch EKEventStore.authorizationStatus(for: .reminder){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    init(){}

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
