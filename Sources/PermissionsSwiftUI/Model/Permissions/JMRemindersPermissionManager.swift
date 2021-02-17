//
//  JMRemindersPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import EventKit

//Contributors: please see JMLocationPermissionManager.swift for code comments
struct JMRemindersPermissionManager{
    static let shared = JMRemindersPermissionManager()

    func requestPermission(completion: @escaping (Bool)->()) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted)
            }
        })
    }
}
