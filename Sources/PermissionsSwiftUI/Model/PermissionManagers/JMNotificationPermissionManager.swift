//
//  File.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import UIKit
import UserNotifications

struct JMNotificationPermissionManager: PermissionManager { 
    static let shared: PermissionManager = JMNotificationPermissionManager()
    var authorizationStatus: AuthorizationStatus{
        var notificationSettings: UNNotificationSettings?
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            notificationManager.getNotificationSettings { setttings in
                notificationSettings = setttings
                semaphore.signal()
            }
        }

        semaphore.wait()
        guard let settings = notificationSettings else{
            print("Notification settings is nil while getting authorization status for JMNotificationPermissionManager")
            return .notDetermined
        }
        switch settings.authorizationStatus{
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        case .provisional:
            return .limited
        default:
            return .denied
        }
    }
    var notificationManager:NotificationManager
    
    init(notificationManager:NotificationManager=UNUserNotificationCenter.shared()){
        self.notificationManager = notificationManager
    }
    
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        notificationManager.requestPermission(options: [.badge,.alert,.sound]){ granted, _ in
                completion(granted)
            
        }
       
        UIApplication.shared.registerForRemoteNotifications()
    }
}
