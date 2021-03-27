//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/26/21.
//

import Foundation

@usableFromInline struct ComponentsInternalStore {
    
    var permissionComponentsStore: PermissionComponentsStore
    @usableFromInline func getPermissionComponent(for permission: PermissionType) -> JMPermission {
        switch permission {
        case .location:
            return permissionComponentsStore.locationPermission
        case .locationAlways:
            return permissionComponentsStore.locationAlwaysPermission
        case .photo:
            return permissionComponentsStore.photoPermission
        case .microphone:
            return permissionComponentsStore.microphonePermisson
        case .camera:
            return permissionComponentsStore.cameraPermission
        case .notification:
            return permissionComponentsStore.notificationPermission
        case .calendar:
            return permissionComponentsStore.calendarPermisson
        case .bluetooth:
            return permissionComponentsStore.bluetoothPermission
        case .tracking:
            return permissionComponentsStore.trackingPermission
        case .contacts:
            return permissionComponentsStore.contactsPermission
        case .motion:
            return permissionComponentsStore.motionPermission
        case .reminders:
            return permissionComponentsStore.remindersPermission
        case .speech:
            return permissionComponentsStore.speechPermission
        case .health:
            return permissionComponentsStore.healthPermission
        case .music:
            return permissionComponentsStore.musicPermission
        }
    }
    
    @usableFromInline mutating func setPermissionComponent(_ component: JMPermission, for permission: PermissionType) {
        switch permission {
        case .location:
            permissionComponentsStore.locationPermission = component
        case .locationAlways:
            permissionComponentsStore.locationAlwaysPermission = component
        case .photo:
            permissionComponentsStore.photoPermission = component
        case .microphone:
            permissionComponentsStore.microphonePermisson = component
        case .camera:
            permissionComponentsStore.cameraPermission = component
        case .notification:
            permissionComponentsStore.notificationPermission = component
        case .calendar:
            permissionComponentsStore.calendarPermisson = component
        case .bluetooth:
            permissionComponentsStore.bluetoothPermission = component
        case .tracking:
            permissionComponentsStore.trackingPermission = component
        case .contacts:
            permissionComponentsStore.contactsPermission = component
        case .motion:
            permissionComponentsStore.motionPermission = component
        case .reminders:
            permissionComponentsStore.remindersPermission = component
        case .speech:
            permissionComponentsStore.speechPermission = component
        case .health:
            permissionComponentsStore.healthPermission = component
        case .music:
            permissionComponentsStore.musicPermission = component

        }

    }
}
