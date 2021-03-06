//
//  PermissionModelGet.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

protocol PermissionTypeProtocol {
    var permissions:[PermissionType]{get}
    func requestPermission(isPermissionGranted: @escaping (Bool) -> Void)
}
//Additional dynamic functionalities for PermissionType
extension PermissionType:PermissionTypeProtocol{

    var permissions:[PermissionType]{
        get{
            store.permissions 
        }
    }
    //Get and set value for current permission type's store
    var currentPermission: JMPermission {
        get{
            switch self {
            case .location:
                return store.locationPermission
            case .locationAlways:
                return store.locationAlwaysPermission
            case .photo:
                return store.photoPermission
            case .microphone:
                return store.microphonePermisson
            case .camera:
                return store.cameraPermission
            case .notification:
                return store.notificationPermission
            case .calendar:
                return store.calendarPermisson
            case .bluetooth:
                return store.bluetoothPermission
            case .tracking:
                return store.trackingPermission
            case .contacts:
                return store.contactsPermission
            case .motion:
                return store.motionPermission
            case .reminders:
                return store.remindersPermission
            case .speech:
                return store.speechPermission
            case .health:
                return store.healthPermission

            }
        }
        set{
            switch self {
            case .location:
                //$0 is first parameter get back from closure, it is the PermissionStore storage instance
                //$1 is second parameter and is a generic for the new value to set
                store.updateStore(property: {$0.locationPermission=$1}, value: newValue)
            case .locationAlways:
                store.updateStore(property: {$0.locationAlwaysPermission=$1}, value: newValue)
            case .photo:
                store.updateStore(property: {$0.photoPermission=$1}, value: newValue)
            case .microphone:
                store.updateStore(property: {$0.microphonePermisson=$1}, value: newValue)
            case .camera:
                store.updateStore(property: {$0.cameraPermission=$1}, value: newValue)
            case .notification:
                store.updateStore(property: {$0.notificationPermission=$1}, value: newValue)
            case .calendar:
                store.updateStore(property: {$0.calendarPermisson=$1}, value: newValue)
            case .bluetooth:
                store.updateStore(property: {$0.bluetoothPermission=$1}, value: newValue)
            case .tracking:
                store.updateStore(property: {$0.trackingPermission=$1}, value: newValue)
            case .contacts:
                store.updateStore(property: {$0.contactsPermission=$1}, value: newValue)
            case .motion:
                store.updateStore(property: {$0.motionPermission=$1}, value: newValue)
            case .reminders:
                store.updateStore(property: {$0.remindersPermission=$1}, value: newValue)
            case .speech:
                store.updateStore(property: {$0.speechPermission=$1}, value: newValue)
            case .health:
                store.updateStore(property: {$0.healthPermission=$1}, value: newValue)
            }
        }
        
    }
    func requestPermission(isPermissionGranted: @escaping (Bool) -> Void) {
        //Pass the $0 argument that specify isPermissionGranted back to UI layer
        getPermissionManager()?.requestPermission{authorized, error in
            isPermissionGranted(authorized)
            
        }
    }
    
    //Gets the correct permission manager for current permission type
    func getPermissionManager() -> PermissionManager?{
        switch self {
        case .location:
            return JMLocationPermissionManager.shared
        case .locationAlways:
            return JMLocationAlwaysPermissionManager.shared
        case .photo:
            return JMPhotoPermissionManager.shared
        case .microphone:
            return JMMicrophonePermissionManager.shared
        case .camera:
            return JMCameraPermissionManager.shared
        case .notification:
            return JMNotificationPermissionManager.shared
        case .calendar:
            return JMCalendarPermissionManager.shared
        case .bluetooth:
            return JMBluetoothPermissionManager.shared

        case .tracking:
            if #available(iOS 14.5, *) {
                return JMTrackingPermissionManager.shared
            }
        case .contacts:
            return JMContactsPermissionManager.shared
        case .motion:
            return JMMotionPermissionManager.shared
        case .reminders:
            return JMRemindersPermissionManager.shared
        case .speech:
            return JMSpeechPermissionManager.shared
        case .health:
            return JMHealthPermissionManager.shared
        }
        return nil

    }
    
}
extension PermissionType:CaseIterable{
    public static var allCases: [PermissionType]{
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
