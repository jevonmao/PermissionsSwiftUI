//
//  PermissionComponentsStore.swift
//  
//
//  Created by Jevon Mao on 3/17/21.
//

import Foundation
import SwiftUI

/**
 The data storage class that contains configurable permission components
 */
@available(iOS 13.0, tvOS 13.0, *)
public struct PermissionComponentsStore {
    //MARK: Creating a new permission components store
    /**
     Creates a new permission components store with default settings
     
     Use this initializer to declare a new instance of `PermissionComponentsStore`. Configure all the individual permission components, including image, title, and description by assigning to their properties.
     For example:
     ```
     let store = PermissionStore()
     store.permissionComponentsStore.cameraPermission = JMPermission(
                                                            imageIcon: AnyView(Image(systemName: "camera.fill")),
                                                            title: "Camera",
                                                            description: "Allow to use your camera", authorized: false)
     ```
     */
    public init(){}
    //MARK: Permission Components
    /// The displayed text and image icon for the biometrics permission
    public var biometricPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "faceid")), 
        title: "Biometrics",
        description: "Allow to lock/hide your data from other persons"
    )
    
    ///The displayed text and image icon for the camera permission
    public var cameraPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "camera.fill")),
        title: "Camera",
        description: "Allow to use your camera")
    ///The displayed text and image icon for the location permission
    public var locationPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
        title: "Location",
        description: "Allow to access your location"
    )
    ///The displayed text and image icon for the location always permission
    public var locationAlwaysPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
        title: "Location Always",
        description: "Allow to access your location"
    )
    ///The displayed text and image icon for the photo library permission
    public var photoPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "photo")),
        title: "Photo Library",
        description: "Allow to access your photos"
    )
    ///The displayed text and image icon for the microphone permission
    public var microphonePermisson = JMPermission(
        imageIcon: AnyView(Image(systemName: "mic.fill")),
        title: "Microphone",
        description: "Allow to record with microphone"
    )
    ///The displayed text and image icon for the notification center permission
    public var notificationPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "bell.fill")),
        title: "Notification",
        description: "Allow to send notifications"
    )
    ///The displayed text and image icon for the calendar permission
    public var calendarPermisson = JMPermission(
        imageIcon: AnyView(Image(systemName: "calendar")),
        title: "Calendar",
        description: "Allow to access calendar"
    )
    ///The displayed text and image icon for the bluetooth permission
    public var bluetoothPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "wave.3.left.circle.fill")),
        title: "Bluetooth",
        description: "Allow to use bluetooth"
    )
    ///The displayed text and image icon for the permission to track across apps and websites
    public var trackingPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "person.circle.fill")),
        title: "Tracking",
        description: "Allow to track your data"
    )
    ///The displayed text and image icon for the contact permission
    public var contactsPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "book.fill")),
        title: "Contacts",
        description: "Allow to access your contacts"
    )
    ///The displayed text and image icon for the motion permission
    public var motionPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "hare.fill")),
        title: "Motion",
        description: "Allow to access your motion sensor data"
    )
    ///The displayed text and image icon for the reminders permission
    public var remindersPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "list.bullet.rectangle")),
        title: "Reminders",
        description: "Allow to access your reminders"
    )
    ///The displayed text and image icon for the speech recognition permission
    public var speechPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "rectangle.3.offgrid.bubble.left.fill")),
        title: "Speech",
        description: "Allow to access speech recognition")
    ///The displayed text and image icon for the health permission
    public var healthPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "heart.fill")),
        title: "health_title".localized,
        description: "health_description".localized)
    ///The displayed text and image icon for the music permission
    public var musicPermission = JMPermission(imageIcon: Image(systemName: "music.note.list").typeErased(),
                                              title: "Music",
                                              description: "Allow to control audio playback")
    ///The displayed text and image icon for the siri permission
    public var siriPermission = JMPermission(imageIcon: Image(systemName: "waveform").typeErased(),
                                             title: "Siri",
                                             description: "Allow Siri to interact with app")
    

}

@available(iOS 13.0, tvOS 13.0, *)
extension PermissionComponentsStore {
    @usableFromInline
    @discardableResult
    mutating func getPermissionComponent(for permission: PermissionType,
                                        modify: (inout JMPermission) -> Void = {_ in}) -> JMPermission {
        switch permission {
        case .location:
            modify(&self.locationPermission)
            return self.locationPermission
        case .biometrics:
            modify(&self.biometricPermission)
            return self.biometricPermission
        case .locationAlways:
            modify(&self.locationAlwaysPermission)
            return self.locationAlwaysPermission
        case .photo:
            modify(&self.photoPermission)
            return self.photoPermission
        case .microphone:
            modify(&self.microphonePermisson)
            return self.microphonePermisson
        case .camera:
            modify(&self.cameraPermission)
            return self.cameraPermission
        case .notification:
            modify(&self.notificationPermission)
            return self.notificationPermission
        case .calendar:
            modify(&self.calendarPermisson)
            return self.calendarPermisson
        case .bluetooth:
            modify(&self.bluetoothPermission)
            return self.bluetoothPermission
        case .tracking:
            modify(&self.trackingPermission)
            return self.trackingPermission
        case .contacts:
            modify(&self.contactsPermission)
            return self.contactsPermission
        case .motion:
            modify(&self.motionPermission)
            return self.motionPermission
        case .reminders:
            modify(&self.remindersPermission)
            return self.remindersPermission
        case .speech:
            modify(&self.speechPermission)
            return self.speechPermission
        case .music:
            modify(&self.musicPermission)
            return self.musicPermission
        #if !os(tvOS)
        case .health:
            modify(&self.healthPermission)
            return self.healthPermission
        #endif
        case .siri:
            modify(&self.siriPermission)
            return self.siriPermission
        }
    }
}

