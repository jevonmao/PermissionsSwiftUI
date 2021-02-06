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

public enum PermissionModel {
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
    ///A permission that allows developers to read & write to device contacts
    case contacts
    ///Permission that give app access to motion and fitness related sensor data
    case motion
    ///The `reminders` permission is needed to interact with device reminders
    case reminders
    ///Permission that allows app to use speech recognition
    case speech
    ///In order for app to track user's data across apps and websites, the tracking permission is needed
    @available(iOS 14.5, *) case tracking
}
extension PermissionModel{
    static func resetPermissionsModelStore(){
        
        PermissionModelStore.permissions = []
        PermissionModelStore.headerText = "Need Permissions"
        PermissionModelStore.headerDescription = """
                                       In order for you use certain features of this app, you need to give permissions. See description for each permission
                                       """
        PermissionModelStore.bottomDescription = """
                                            Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings
                                            """
        PermissionModelStore.cameraPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "camera.fill")),
            title: "Camera",
            description: "Allow to use your camera", authorized: false)
        
        PermissionModelStore.locationPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
            title: "Location",
            description: "Allow to access your location", authorized: false
        )
        PermissionModelStore.locationAlwaysPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
            title: "Location Always",
            description: "Allow to access your location", authorized: false
        )
        PermissionModelStore.photoPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "photo")),
            title: "Photo Library",
            description: "Allow to access your photos", authorized: false
        )
        PermissionModelStore.microphonePermisson = JMPermission(
            imageIcon: AnyView(Image(systemName: "mic.fill")),
            title: "Microphone",
            description: "Allow to record with microphone", authorized: false
        )
        PermissionModelStore.notificationPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "bell.fill")),
            title: "Notification",
            description: "Allow to send notifications", authorized: false
        )
        PermissionModelStore.calendarPermisson = JMPermission(
            imageIcon: AnyView(Image(systemName: "calendar")),
            title: "Calendar",
            description: "Allow to access calendar", authorized: false
        )
        PermissionModelStore.bluetoothPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "wave.3.left.circle.fill")),
            title: "Bluetooth",
            description: "Allow to use bluetooth", authorized: false
        )
        PermissionModelStore.trackingPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "person.circle.fill")),
            title: "Tracking",
            description: "Allow to track your data", authorized: false
        )
        PermissionModelStore.contactsPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "book.fill")),
            title: "Contacts",
            description: "Allow to access your contacts", authorized: false
        )
        PermissionModelStore.motionPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "hare.fill")),
            title: "Motion",
            description: "Allow to access your motion sensor data", authorized: false
        )
        PermissionModelStore.remindersPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "list.bullet.rectangle")),
            title: "Reminders",
            description: "Allow to access your reminders", authorized: false
        )
        PermissionModelStore.speechPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "rectangle.3.offgrid.bubble.left.fill")),
            title: "Speech",
            description: "Allow to access speech recognition", authorized: false
        )
    }
    struct PermissionModelStore {
        static var permissions: [PermissionModel] = []
        static var headerText:String = "Need Permissions"
        static var headerDescription:String = """
                                       In order for you use certain features of this app, you need to give permissions. See description for each permission
                                       """
        static var bottomDescription:String = """
                                            Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings
                                            """
        static var cameraPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "camera.fill")),
            title: "Camera",
            description: "Allow to use your camera", authorized: false)
        
        static var locationPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
            title: "Location",
            description: "Allow to access your location", authorized: false
        )
        static var locationAlwaysPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
            title: "Location Always",
            description: "Allow to access your location", authorized: false
        )
        static var photoPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "photo")),
            title: "Photo Library",
            description: "Allow to access your photos", authorized: false
        )
        static var microphonePermisson = JMPermission(
            imageIcon: AnyView(Image(systemName: "mic.fill")),
            title: "Microphone",
            description: "Allow to record with microphone", authorized: false
        )
        static var notificationPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "bell.fill")),
            title: "Notification",
            description: "Allow to send notifications", authorized: false
        )
        static var calendarPermisson = JMPermission(
            imageIcon: AnyView(Image(systemName: "calendar")),
            title: "Calendar",
            description: "Allow to access calendar", authorized: false
        )
        static var bluetoothPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "wave.3.left.circle.fill")),
            title: "Bluetooth",
            description: "Allow to use bluetooth", authorized: false
        )
        static var trackingPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "person.circle.fill")),
            title: "Tracking",
            description: "Allow to track your data", authorized: false
        )
        static var contactsPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "book.fill")),
            title: "Contacts",
            description: "Allow to access your contacts", authorized: false
        )
        static var motionPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "hare.fill")),
            title: "Motion",
            description: "Allow to access your motion sensor data", authorized: false
        )
        static var remindersPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "list.bullet.rectangle")),
            title: "Reminders",
            description: "Allow to access your reminders", authorized: false
        )
        static var speechPermission = JMPermission(
            imageIcon: AnyView(Image(systemName: "rectangle.3.offgrid.bubble.left.fill")),
            title: "Speech",
            description: "Allow to access speech recognition", authorized: false
        )
        }

    var currentPermission: JMPermission {
        get{
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
       
    }
    func updatePermissionModelStore(to model:JMPermission){
        switch self {
        case .location:
            PermissionModelStore.locationPermission = model
        case .locationAlways:
            PermissionModelStore.locationAlwaysPermission = model
        case .photo:
            PermissionModelStore.photoPermission = model
        case .microphone:
            PermissionModelStore.microphonePermisson = model
        case .camera:
            PermissionModelStore.cameraPermission = model
        case .notification:
            PermissionModelStore.notificationPermission = model
        case .calendar:
            PermissionModelStore.calendarPermisson = model
        case .bluetooth:
            PermissionModelStore.bluetoothPermission = model
        case .tracking:
            PermissionModelStore.trackingPermission = model
        case .contacts:
            PermissionModelStore.contactsPermission = model
        case .motion:
            PermissionModelStore.motionPermission = model
        case .reminders:
            PermissionModelStore.remindersPermission = model
        case .speech:
            PermissionModelStore.speechPermission = model
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
extension PermissionModel:CaseIterable{
    public static var allCases: [PermissionModel]{
        if #available(iOS 14.5, *) {
            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech,.tracking]
        } else {
            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech]
        }
    }
}
/**
 A data model that defines a JPPermission component and its data
 
 The `imageIcon` stores the symbol image displayed on each permission component
 The `title` defines the title text for each permission component, and the `description` defines the detailed text for each permission component.
 */
public struct JMPermission:Equatable, Hashable{
    public static func == (lhs: JMPermission, rhs: JMPermission) -> Bool {
        if lhs.title == rhs.title && lhs.description == rhs.description && lhs.authorized == rhs.authorized{
            return true
        }
        else{
            return false
        }
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(authorized)
    }
    
    var imageIcon: AnyView
    var title: String
    var description: String
    var authorized:Bool
    
}

