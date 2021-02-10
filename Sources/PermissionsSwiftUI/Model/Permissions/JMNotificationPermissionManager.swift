//
//  File.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import UIKit
import UserNotifications

struct JMNotificationPermissionManager {
    static let shared = JMNotificationPermissionManager()
    var notificationManager:NotificationManager
    init(notificationManager:NotificationManager=UNUserNotificationCenter.shared()){
        self.notificationManager = notificationManager
    }
    func fetchAuthorizationStatus() -> UNAuthorizationStatus? {
        var notificationSettings: UNNotificationSettings?
        let semaphore = DispatchSemaphore(value: 0)

        DispatchQueue.global().async {
            notificationManager.getNotificationSettings { setttings in
                notificationSettings = setttings
                semaphore.signal()
            }
        }

        semaphore.wait()
        return notificationSettings?.authorizationStatus
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void?) {
        notificationManager.requestPermission(options: [.badge,.alert,.sound]){ granted, _ in
                completion(granted)
            
        }
       
        UIApplication.shared.registerForRemoteNotifications()
    }
}
