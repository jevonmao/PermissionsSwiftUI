//
//  JMCalendarPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import EventKit
import UIKit

//Contributors: please see JMLocationPermissionManager.swift for code comments
struct JMCalendarPermissionManager {
    static let shared = JMCalendarPermissionManager()
    func requestPermission(completion: @escaping (Bool) -> Void?) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, _: Error?) in
            DispatchQueue.main.async {
                completion(accessGranted)
            }
        })
    }
}
