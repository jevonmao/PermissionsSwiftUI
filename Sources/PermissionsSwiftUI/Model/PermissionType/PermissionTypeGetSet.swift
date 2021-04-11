//
//  PermissionModelGet.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

protocol PermissionTypeProtocol {
    func getPermissionManager() -> PermissionManager.Type?
}
//Additional dynamic functionalities for PermissionType
extension PermissionType: PermissionTypeProtocol { 
    //Gets the correct permission manager for current permission type
    func getPermissionManager() -> PermissionManager.Type? {
        switch self {
        case .location:
            return JMLocationPermissionManager.self
            
        case .photo:
            return JMPhotoPermissionManager.self
            
        case .notification:
            return JMNotificationPermissionManager.self
        case .bluetooth:
            return JMBluetoothPermissionManager.self
        case .tracking:
            if #available(iOS 14, tvOS 14, *) {
                return JMTrackingPermissionManager.self
            }
        #if !os(tvOS)
        case .locationAlways:
            return JMLocationAlwaysPermissionManager.self
        case .microphone:
            return JMMicrophonePermissionManager.self
        case .camera:
            return JMCameraPermissionManager.self
        case .calendar:
            return JMCalendarPermissionManager.self
        case .contacts:
            return JMContactsPermissionManager.self
        case .motion:
            return JMMotionPermissionManager.self
        case .reminders:
            return JMRemindersPermissionManager.self
        case .speech:
            return JMSpeechPermissionManager.self
        case .health:
            return JMHealthPermissionManager.self
        case .music:
            return JMMusicPermissionManager.self
        #endif
        }
        return nil
        
    }
    
}
extension PermissionType: CaseIterable {
    public static var allCases: [PermissionType] {
        #if !os(tvOS)
        if #available(iOS 14, *) {
            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech,.tracking, .health(categories: nil)]
        } else {
            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech, .health(categories: nil)]
        }
        #else
        if #available(tvOS 14, *) {
            return [.location, .photo, .notification, .bluetooth, .tracking]
        }
        else {
            return [.location, .photo, .notification, .bluetooth]
        }
        #endif
    }
    var rawValue: String {
        guard let label = Mirror(reflecting: self).children.first?.label else {
            return .init(describing: self)
        }
        return label
    }
}
