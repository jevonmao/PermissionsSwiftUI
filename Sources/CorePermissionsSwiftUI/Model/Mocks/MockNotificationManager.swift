//
//  MockNotificationManager.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import Foundation
import UserNotifications

protocol NotificationManager {
    static func shared() -> NotificationManager
    func requestPermission(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
    func getNotificationSettings(completionHandler: @escaping (UNNotificationSettings) -> Void)
}
extension UNUserNotificationCenter:NotificationManager{
    static var isTestingMode = false
    static func shared() -> NotificationManager {
        return isTestingMode ? MockNotificationManager.shared() : UNUserNotificationCenter.current()
    }
    func requestPermission(options: UNAuthorizationOptions=[], completionHandler: @escaping (Bool, Error?) -> Void) {
        self.requestAuthorization(options: options) { granted, error in
            completionHandler(granted,error)
        }
    }
    
}
final class MockNotificationManager:NotificationManager{
    var authStatus:UNAuthorizationStatus = .notDetermined
    func getNotificationSettings(completionHandler: @escaping (UNNotificationSettings) -> Void) {
        completionHandler(UNNotificationSettings(coder: MockNSCoder(authorizationStatus: authStatus.rawValue))!)
        
    }
    
    static func shared() -> NotificationManager {
        MockNotificationManager()
    }
    
    
    func requestPermission(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        switch authStatus{
        case .denied:
            completionHandler(false,NSError(domain:"", code:0, userInfo:nil))
        case .ephemeral:
            completionHandler(false,nil)
        default:
            completionHandler(true,nil)
            authStatus = .authorized
        }
    }
    
    
}
final class MockNSCoder: NSCoder {
    var authorizationStatus:Int
    init(authorizationStatus:Int){
        self.authorizationStatus = authorizationStatus
    }
    override func decodeInt64(forKey key: String) -> Int64 {
        return Int64(authorizationStatus)
    }
    
    override func decodeBool(forKey key: String) -> Bool {
        return true
    }
}
