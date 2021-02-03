//
//  PermissionModel.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import Foundation
import SwiftUI

/**
 The types of iOS system permission for show in the JMPermissions view
 
 Pass this as a parameter into JMPermissions View Modifier will display 3 UI elements–location, photo, and microphone.
 ```
 [.location, photo, microphone]
 ```
 */

public enum PermissionModel:CaseIterable {
    ///The `location` permission allows the device's positoin to be tracked
    case location
    ///The `locationAlways` permission provides location data even if app is in background
    case locationAlways
    ///Used to access the user's photo library
    case photo
    ///Permission allows developers to interact with the device microphone
    case microphone
    ///Permission that allows developers to interact with on-device camera
    case camera
    ///The `notification` permission allows the iOS system to receive notification from app
    case notification
    ///Permission that allows app to read & write to device calendar
    case calendar
    ///Permission that allows app to access device's bluetooth technologies
    case bluetooth
    ///In order for app to track user's data across apps and websites, the tracking permission is needed
    case tracking
    ///A permission that allows developers to read & write to device contacts
    case contacts
    ///Permission that give app access to motion and fitness related sensor data
    case motion
    ///The `reminders` permission is needed to interact with device reminders
    case reminders
    ///Permission that allows app to use speech recognition
    case speech
}
extension PermissionModel{
    
    enum PermissionModelStore {
        static var permissions: [PermissionModel] = []
        static var headerText:String = "Need Permissions"
        static var headerDescription:String = """
                                       In order for you use certain features of this app, you need to give permissions. See description for each permission
                                       """
        static var bottomDescription:String = """
                                            Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings
                                            """
        static var cameraPermission = JMPermission(
            imageIcon: Image(systemName: "camera.fill"),
            title: "Camera",
            description: "Allow to use your camera"
        )
        static var locationPermission = JMPermission(
            imageIcon: Image(systemName: "location.fill.viewfinder"),
            title: "Location",
            description: "Allow to access your location"
        )
        static var locationAlwaysPermission = JMPermission(
            imageIcon: Image(systemName: "location.fill.viewfinder"),
            title: "Location Always",
            description: "Allow to access your location"
        )
        static var photoPermission = JMPermission(
            imageIcon: Image(systemName: "photo"),
            title: "Photo Library",
            description: "Allow to access your photos"
        )
        static var microphonePermisson = JMPermission(
            imageIcon: Image(systemName: "mic.fill"),
            title: "Microphone",
            description: "Allow to record with microphone"
        )
        static var notificationPermission = JMPermission(
            imageIcon: Image(systemName: "bell.fill"),
            title: "Notification",
            description: "Allow to send notifications"
        )
        static var calendarPermisson = JMPermission(
            imageIcon: Image(systemName: "calendar"),
            title: "Calendar",
            description: "Allow to access calendar"
        )
        static var bluetoothPermission = JMPermission(
            imageIcon: Image(systemName: "wave.3.left.circle.fill"),
            title: "Bluetooth",
            description: "Allow to use bluetooth"
        )
        static var trackingPermission = JMPermission(
            imageIcon: Image(systemName: "person.circle.fill"),
            title: "Tracking",
            description: "Allow to track your data"
        )
        static var contactsPermission = JMPermission(
            imageIcon: Image(systemName: "book.fill"),
            title: "Contacts",
            description: "Allow to access your contacts"
        )
        static var motionPermission = JMPermission(
            imageIcon: Image(systemName: "hare.fill"),
            title: "Motion",
            description: "Allow to access your motion sensor data"
        )
        static var remindersPermission = JMPermission(
            imageIcon: Image(systemName: "list.bullet.rectangle"),
            title: "Reminderes",
            description: "Allow to access your reminders"
        )
        static var speechPermission = JMPermission(
            imageIcon: Image(systemName: "rectangle.3.offgrid.bubble.left.fill"),
            title: "Speech",
            description: "Allow to access speech recognition"
        )
        }
    var currentPermission: JMPermission {
        switch self {
        case .location:
            return PermissionModelStore.locationPermission
        case .locationAlways:
            return PermissionModelStore.locationAlwaysPermission
        case .photo:
            return PermissionModelStore.photoPermission
        case .microphone:
            return PermissionModelStore.microphonePermisson
        case .camera:
            return PermissionModelStore.cameraPermission
        case .notification:
            return PermissionModelStore.notificationPermission
        case .calendar:
            return PermissionModelStore.calendarPermisson
        case .bluetooth:
            return PermissionModelStore.bluetoothPermission
        case .tracking:
            return PermissionModelStore.trackingPermission
        case .contacts:
            return PermissionModelStore.contactsPermission
        case .motion:
            return PermissionModelStore.motionPermission
        case .reminders:
            return PermissionModelStore.remindersPermission
        case .speech:
            return PermissionModelStore.speechPermission
            
        }
    }

    func requestPermission(isPermissionGranted: @escaping (Bool) -> Void) {
        switch self {
        case .location:
            JMLocationPermissionManager.shared.requestInUsePermission { authorized in
                print("Permission \(authorized)")
                isPermissionGranted(authorized)
            }
        case .locationAlways:
            JMLocationPermissionManager.shared.requestAlwaysPermission { authorized in
                print("Permission \(authorized)")
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
            if #available(iOS 14, *) {
                JMTrackingPermissionManager.shared.requestPermission{authorized in
                    print(authorized)
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
        }
    }
}
public struct JMPermission{
    var imageIcon: Image
    var title: String
    var description: String
}

