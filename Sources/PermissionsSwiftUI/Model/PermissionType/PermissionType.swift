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

public enum PermissionType: Hashable {

    public static func == (lhs: PermissionType, rhs: PermissionType) -> Bool {
        lhs.rawValue == rhs.rawValue ? true : false
    }
    
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
    /**
     Permission that allows app to access healthkit information
     
     - Note: Extensive Info.plist  values and configurations are required for HealthKit authorization. Please see Apple Developer [website](https://developer.apple.com/documentation/healthkit/authorizing_access_to_health_data) for details. \n
     
     For example, passing in a `Set` of `HKSampleType`:
     ```
     [.health(categories: .init(readAndWrite: Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])))]
     ```
     */
    case health(categories: HKAccess?=nil)
    ///Permission that allows app to use speech recognition
    case speech
    ///Permission that allows app to control audio playback of the device
    case music
    ///In order for app to track user's data across apps and websites, the tracking permission is needed
    @available(iOS 14, *) case tracking
}



