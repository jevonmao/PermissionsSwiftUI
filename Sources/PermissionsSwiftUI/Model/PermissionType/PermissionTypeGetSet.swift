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
        case .locationAlways:
            return JMLocationAlwaysPermissionManager.self
        case .photo:
            return JMPhotoPermissionManager.self
        case .microphone:
            return JMMicrophonePermissionManager.self
        case .camera:
            return JMCameraPermissionManager.self
        case .notification:
            return JMNotificationPermissionManager.self
        case .calendar:
            return JMCalendarPermissionManager.self
        case .bluetooth:
            return JMBluetoothPermissionManager.self  
        case .tracking:
            if #available(iOS 14.5, *) {
                return JMTrackingPermissionManager.self
            }
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
        }
        return nil

    }
    
}
extension PermissionType: CaseIterable {
    public static var allCases: [PermissionType] {
                if #available(iOS 14.5, *) {
                    return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech,.tracking, .health(categories: nil)]
                } else {
                    return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech, .health(categories: nil)]
                }
    }
    var rawValue: String {
            guard let label = Mirror(reflecting: self).children.first?.label else {
                return .init(describing: self)
            }
            return label
        }
}
