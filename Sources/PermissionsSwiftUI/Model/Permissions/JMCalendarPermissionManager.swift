//
//  JMCalendarPermissionManager.swift
//  
//
//  Created by Jevon Mao on 1/31/21.
//

import UIKit
import EventKit

struct JMCalendarPermissionManager{
    static let shared = JMCalendarPermissionManager()
    func requestPermission(completion: @escaping (Bool)->()?) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted)
            }
        })
    }
}
