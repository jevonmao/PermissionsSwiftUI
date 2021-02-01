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
    case location
    case locationAlways
    case photo
    case microphone
    case camera
    case notification
    case calendar
    case bluetooth
    
    enum PermissionModelStore {
        static var permissions: [PermissionModel] = []
        static var cameraPermission = JMPermission(imageIcon: Image(systemName: "camera.fill"), title: "Camera", description: "Allow to use your camera")
        static var locationPermission = JMPermission(imageIcon: Image(systemName: "location.fill.viewfinder"), title: "Location", description: "Allow to access your location")
        static var locationAlwaysPermission = JMPermission(imageIcon: Image(systemName: "location.fill.viewfinder"), title: "Location Always", description: "Allow to access your location")
        static var photoPermission = JMPermission(imageIcon: Image(systemName: "photo"), title: "Photo Library", description: "Allow to access your photos")
        static var microphonePermisson = JMPermission(imageIcon: Image(systemName: "mic.fill"), title: "Microphone", description: "Allow to record with microphone")
        static var notificationPermission = JMPermission(imageIcon: Image(systemName: "bell.fill"), title: "Notification", description: "Allow to send notifications")
        static var calendarPermisson = JMPermission(imageIcon: Image(systemName: "calendar"), title: "Calendar", description: "Allow to access calendar")
        static var bluetoothPermission = JMPermission(imageIcon: Image(systemName: "wave.3.left.circle.fill"), title: "Bluetooth", description: "Allow to use bluetooth")
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
            JMBluetoothPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
         
        case .bluetooth:
            JMCalendarPermissionManager.shared.requestPermission { authorized in
                isPermissionGranted(authorized)
            }
        }
    }
}

public struct JMPermission {
    var imageIcon: Image
    var title: String
    var description: String
}
