//
//  PermissionModel.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import Foundation
import SwiftUI

public enum PermissionModel{
    case location
    case locationAlways
    case photo
    case microphone
    case camera
    case notification
    case calendar
    case bluetooth
    
    var currentPermission:JMPermission{
        switch self{
        case .location:
            return JMPermission(imageIcon: Image(systemName: "location.fill.viewfinder"), title: "Location", description: "Allow to access your location")
        case .locationAlways:
            return JMPermission(imageIcon: Image(systemName: "location.fill.viewfinder"), title: "Location Always", description: "Allow to access your location")
        case .photo:
            return JMPermission(imageIcon: Image(systemName: "photo"), title: "Photo Library", description: "Allow to access your photos")
        case .microphone:
            return JMPermission(imageIcon: Image(systemName: "mic.fill"), title: "Microphone", description: "Allow to record with microphone")
        case .camera:
            return JMPermission(imageIcon: Image(systemName: "camera.fill"), title: "Camera", description: "Allow to use your camera")
        case .notification:
            return JMPermission(imageIcon: Image(systemName: "bell.fill"), title: "Notification", description: "Allow to send notifications")
        case .calendar:
            return JMPermission(imageIcon: Image(systemName: "calendar"), title: "Calendar", description: "Allow to access calendar")
        case .bluetooth:
            return JMPermission(imageIcon: Image(systemName: "wave.3.left.circle.fill"), title: "Bluetooth", description: "Allow to use bluetooth")
        }
    }
    func requestPermission(isPermissionGranted: @escaping (Bool) -> Void){
        switch self{
        case .location:
            JMLocationPermissionManager.shared.requestInUsePermission{authorized in
                print("Permission \(authorized)")
                isPermissionGranted(authorized)
            }
        case .locationAlways:
            JMLocationPermissionManager.shared.requestAlwaysPermission{authorized in
                print("Permission \(authorized)")
                isPermissionGranted(authorized)
            }
        case .photo:
            JMPhotoPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
                
            }
        case .microphone:
            JMMicPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
                
            }
        case .camera:
            JMCameraPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
            }
        case .notification:
            JMNotificationPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
            }
        case .calendar:
            JMBluetoothPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
            }
         
        case .bluetooth:
            JMCalendarPermissionManager.shared.requestPermission{authorized in
                isPermissionGranted(authorized)
            }
        }
    }
    
    
}

struct JMPermission{
    var imageIcon:Image
    var title:String
    var description:String
}
