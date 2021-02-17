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
    //Get all permissions user selected
    var permissions:[PermissionType]{
        get{
            PermissionStore.shared.permissions 
        }
    }
    //Get and set value for current permission type's store
    var currentPermission: JMPermission {
        get{
            let store = PermissionStore.shared
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
                PermissionStore.shared.updateStore(property: {$0.locationPermission=$1}, value: newValue)
            case .locationAlways:
                PermissionStore.shared.updateStore(property: {$0.locationAlwaysPermission=$1}, value: newValue)
            case .photo:
                PermissionStore.shared.updateStore(property: {$0.photoPermission=$1}, value: newValue)
            case .microphone:
                PermissionStore.shared.updateStore(property: {$0.microphonePermisson=$1}, value: newValue)
            case .camera:
                PermissionStore.shared.updateStore(property: {$0.cameraPermission=$1}, value: newValue)
            case .notification:
                PermissionStore.shared.updateStore(property: {$0.notificationPermission=$1}, value: newValue)
            case .calendar:
                PermissionStore.shared.updateStore(property: {$0.calendarPermisson=$1}, value: newValue)
            case .bluetooth:
                PermissionStore.shared.updateStore(property: {$0.bluetoothPermission=$1}, value: newValue)
            case .tracking:
                PermissionStore.shared.updateStore(property: {$0.trackingPermission=$1}, value: newValue)
            case .contacts:
                PermissionStore.shared.updateStore(property: {$0.contactsPermission=$1}, value: newValue)
            case .motion:
                PermissionStore.shared.updateStore(property: {$0.motionPermission=$1}, value: newValue)
            case .reminders:
                PermissionStore.shared.updateStore(property: {$0.remindersPermission=$1}, value: newValue)
            case .speech:
                PermissionStore.shared.updateStore(property: {$0.speechPermission=$1}, value: newValue)
            case .health:
                PermissionStore.shared.updateStore(property: {$0.healthPermission=$1}, value: newValue)
            }
        }
        
    }
    //Request permission for the current enum type
    func requestPermission(isPermissionGranted: @escaping (Bool) -> Void) {
        //Actual system API calls and logic handled in permission managers
        switch self {
        case .location:
            JMLocationPermissionManager.shared.requestInUsePermission { authorized in
                isPermissionGranted(authorized)
            }
        case .locationAlways:
            JMLocationPermissionManager.shared.requestAlwaysPermission { authorized in
                isPermissionGranted(authorized)
            }
        case .photo:
            JMPhotoPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
        case .microphone:
            JMMicPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
        case .camera:
            JMCameraPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
        case .notification:
            JMNotificationPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
        case .calendar:
            JMCalendarPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
            
        case .bluetooth:
            JMBluetoothPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
                
            }
        case .tracking:
            if #available(iOS 14.5, *) {
                JMTrackingPermissionManager.shared.requestPermission{authorized in
                    isPermissionGranted(authorized)
                }
            }
        case .contacts:
            JMContactsPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
            }
        case .motion:
            JMMotionPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
            }
        case .reminders:
            JMRemindersPermissionManager.shared.requestPermission{
                isPermissionGranted($0)
            }
        case .speech:
            JMSpeechPermissionManager.shared.requestPermission{
                isPermissionGranted($0)
            }
        case .health(let HKPermissions):
            JMHealthPermissionManager.shared.requestPermission(for: HKPermissions){
                isPermissionGranted($0)
            }
        }
    }
    
}
extension PermissionType:CaseIterable{
    public static var allCases: [PermissionType]{
        return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech]
        //        if #available(iOS 14.5, *) {
        //            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech,.tracking]
        //        } else {
        //            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech]
        //        }
    }
}
