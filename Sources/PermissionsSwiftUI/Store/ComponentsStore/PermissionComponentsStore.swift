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
public struct PermissionComponentsStore {
    #warning("Remove authorized property from initializer")
    //MARK: Creating a new permission components store
    public init(){}
    //MARK: Permission Components
    ///The displayed text and image icon for the camera permission
    public var cameraPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "camera.fill")),
        title: "Camera",
        description: "Allow to use your camera", authorized: false)
    ///The displayed text and image icon for the location permission
    public var locationPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
        title: "Location",
        description: "Allow to access your location", authorized: false
    )
    ///The displayed text and image icon for the location always permission
    public var locationAlwaysPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
        title: "Location Always",
        description: "Allow to access your location", authorized: false
    )
    ///The displayed text and image icon for the photo library permission
    public var photoPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "photo")),
        title: "Photo Library",
        description: "Allow to access your photos", authorized: false
    )
    ///The displayed text and image icon for the microphone permission
    public var microphonePermisson = JMPermission(
        imageIcon: AnyView(Image(systemName: "mic.fill")),
        title: "Microphone",
        description: "Allow to record with microphone", authorized: false
    )
    ///The displayed text and image icon for the notification center permission
    public var notificationPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "bell.fill")),
        title: "Notification",
        description: "Allow to send notifications", authorized: false
    )
    ///The displayed text and image icon for the calendar permission
    public var calendarPermisson = JMPermission(
        imageIcon: AnyView(Image(systemName: "calendar")),
        title: "Calendar",
        description: "Allow to access calendar", authorized: false
    )
    ///The displayed text and image icon for the bluetooth permission
    public var bluetoothPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "wave.3.left.circle.fill")),
        title: "Bluetooth",
        description: "Allow to use bluetooth", authorized: false
    )
    ///The displayed text and image icon for the permission to track across apps and websites
    public var trackingPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "person.circle.fill")),
        title: "Tracking",
        description: "Allow to track your data", authorized: false
    )
    ///The displayed text and image icon for the contact permission
    public var contactsPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "book.fill")),
        title: "Contacts",
        description: "Allow to access your contacts", authorized: false
    )
    ///The displayed text and image icon for the motion permission
    public var motionPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "hare.fill")),
        title: "Motion",
        description: "Allow to access your motion sensor data", authorized: false
    )
    ///The displayed text and image icon for the reminders permission
    public var remindersPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "list.bullet.rectangle")),
        title: "Reminders",
        description: "Allow to access your reminders", authorized: false
    )
    ///The displayed text and image icon for the speech recognition permission
    public var speechPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "rectangle.3.offgrid.bubble.left.fill")),
        title: "Speech",
        description: "Allow to access speech recognition")
    ///The displayed text and image icon for the health permission
    public var healthPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "heart.fill")),
        title: "Health",
        description: "Allow to access your health information")
    ///The displayed text and image icon for the music permission
    public var musicPermission = JMPermission(imageIcon: Image(systemName: "music.note.list").typeErased(),
                                              title: "Music",
                                              description: "Allow to control audio playback")
    

}

