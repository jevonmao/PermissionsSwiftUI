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
    var authorizationStatus: AuthorizationStatus{
        var notificationSettings: UNNotificationSettings?
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            notificationManager.getNotificationSettings { settings in
                notificationSettings = settings
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
    var notificationManager:NotificationManager = UNUserNotificationCenter.shared()
    
    init(notificationManager:NotificationManager=UNUserNotificationCenter.shared()){
        self.notificationManager = notificationManager
    }
    init(){}

    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        notificationManager.requestPermission(options: [.badge,.alert,.sound, .criticalAlert]){ granted, error in
            DispatchQueue.main.async {
                completion(granted, error)
            }
        }
       
        UIApplication.shared.registerForRemoteNotifications()
    }
}
