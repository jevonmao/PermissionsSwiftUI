//
//  PermissionModel.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import Foundation
import SwiftUI
#if PERMISSIONSWIFTUI_HEALTH
import HealthKit
#endif

/**
 The types of iOS system permission for show in the JMPermissions view
 
 Pass this as a parameter into JMPermissions View Modifier will display 3 UI elements–location, photo, and microphone.
 ```
 [.location, photo, microphone]
 ```
 */
@available(iOS 13.0, tvOS 13.0, *)
public enum PermissionType: Hashable, Equatable {
    public static func == (lhs: PermissionType, rhs: PermissionType) -> Bool {
        lhs.rawValue == rhs.rawValue ? true : false
    }
    
    ///The `location` permission allows the device's positoin to be tracked
    case location

    ///Used to access the user's photo library
    case photo

    ///The `notification` permission allows the iOS system to receive notification from app
    case notification

    ///Permission that allows app to access device's bluetooth technologies
    case bluetooth

    ///Permission that allows Siri and Maps to communicate with your app
    case siri
    
    /// Permission that grants access to biometric authentication in your application.
    ///
    /// The `biometrics` permission enables the use of biometric authentication features, such as Face ID, Touch ID or OpticID,
    /// allowing users to securely authenticate themselves using their unique biometric data.
    @available(iOS 13, macOS 11, *) case biometrics
    
    ///In order for app to track user's data across apps and websites, the tracking permission is needed
    @available(iOS 14, tvOS 14, *) case tracking
#if !os(tvOS)
    /**
     Permission that allows app to access healthkit information

     - Note: Extensive Info.plist  values and configurations are required for HealthKit authorization. Please see Apple Developer [website](https://developer.apple.com/documentation/healthkit/authorizing_access_to_health_data) for details. \n

     For example, passing in a `Set` of `HKSampleType`:
     ```
     [.health(categories: .init(readAndWrite: Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])))]
     ```
     */
    case health
#endif

    ///The `locationAlways` permission provides location data even if app is in background
    @available(tvOS, unavailable) case locationAlways

    ///Permission allows developers to interact with the device microphone
    @available(tvOS, unavailable) case microphone

    ///Permission that allows developers to interact with on-device camera
    @available(tvOS, unavailable) case camera

    ///A permission that allows developers to read & write to device contacts
    @available(tvOS, unavailable) case contacts

    ///Permission that give app access to motion and fitness related sensor data
    @available(tvOS, unavailable) case motion

    ///Permission that allows app to read & write to device reminder before iOS 17
    @available(tvOS, unavailable, deprecated: 16.0, obsoleted: 17.0)
    case reminders

    ///Permission that allows app to read & write to device calendar before iOS 17
    @available(tvOS, unavailable, deprecated: 16.0, obsoleted: 17.0)
    case calendar

    ///Permission that allows app to use speech recognition
    @available(tvOS, unavailable) case speech

    ///Permission that allows app to control audio playback of the device
    @available(tvOS, unavailable) case music
}



