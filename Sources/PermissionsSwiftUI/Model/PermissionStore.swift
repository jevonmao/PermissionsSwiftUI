//
//  PermissionModelSet.swift
//
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

//MARK: - Storage
/**
 The global shared storage for PermissionsSwiftUI
 */
public struct PermissionStore {
    //MARK: Init and Singleton Management
    /**
     Initalizes and returns a new instance of `PermissionStore`
     
     The `PermissionStore` initliazer accepts no parameters, instead, set properties after intialization:
     ```
     let store = PermissionStore()
     store.mainTexts.headerText = "PermissionsSwiftUI is the best library"
     */
    public init(){}
    //a private singleton instance that allows read & write, but for this file's methods only
    fileprivate static var mutableShared = PermissionStore()
    //Read only singleton exposed to other parts of program
    static var shared:PermissionStore{
        get{
            mutableShared
        }
    }
    ///A global array of permissions that configures the permissions to request
    public var permissions: [PermissionType] = []
    var permissionsToAsk: [PermissionType]{
        FilterPermissions.filterForShouldAskPermission(for: permissions)
    }
    //MARK: Secondary Components
    ///The text for text label components, including header and descriptions
    public var mainTexts = MainTexts()
    ///The color configuration for permission allow buttons
    public var allButtonColors = AllButtonColors()
    ///Whether to auto dismiss the modal after last permission is allowed
    public var autoDismissModal: Bool = true
    ///Whether to auto dismiss the alert after last permission is allowed
    public var autoDismissAlert: Bool = true
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    public var autoCheckModalAuth: Bool = true
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    public var autoCheckAlertAuth: Bool = true
    ///Override point for executing action when PermissionsSwiftUI view appears
    public var onAppear: (()->Void)?
    ///Override point for executing action when PermissionsSwiftUI view disappears
    public var onDisappear: (()->Void)?
    public struct MainTexts{
        ///Text to display for header text
        public var headerText: String = "Need Permissions"
        ///Text to display for header description text
        public var headerDescription: String = """
                                       In order for you use certain features of this app, you need to give permissions. See description for each permission
                                       """
        ///Text to display for bottom part description text
        public var bottomDescription: String = """
                                            Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings
                                            """
    }
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
        description: "Allow to access speech recognition", authorized: false
    )
    ///The displayed text and image icon for the health permission
    public var healthPermission = JMPermission(
        imageIcon: AnyView(Image(systemName: "heart.fill")),
        title: "Health",
        description: "Allow to access your health information",
        authorized: false)
    
}
// MARK: - Updating methods
extension PermissionStore{
    //Used for unit testing, need to reset storage before each subtest
    static func resetPermissionsModelStore(){
        mutableShared = PermissionStore()
    }
    //inout enables caller to modify PermissionStore
    func updateStore<T>(property:(inout PermissionStore, T)->Void, value:T){
        //Closure passes back PermissionStore instance, and the generic value passed in method
        property(&PermissionStore.mutableShared, value)
    }
    
}
// MARK: - Button Customizations
/**
 `AllButtonColors` encapsulates the color configuration for all states of the allow button
    
 To customize button colors:
 1. Define a new instance of the `AllButtonColors` struct
 2. Add the `setAllowButtonColor(to colors:AllButtonColors)` modifier to your view
 3. Pass in the `AllButtonColors` struct previously into the proper parameter
 */
public struct AllButtonColors{
    //MARK: Creating New Button Configs
    /**
     - parameters:
        - buttonIdle: The button color configuration for the default, idle state
        - buttonAllowed: The button color configuration for the highlighted, allowed state
        - buttonDenied: The button color configuration for the user explicitly denied state
     */
    public init(buttonIdle: ButtonColor, buttonAllowed: ButtonColor, buttonDenied: ButtonColor){
        self.init()
        self.buttonIdle = buttonIdle
        self.buttonAllowed = buttonAllowed
        self.buttonDenied = buttonDenied
    }
    /**
     - parameters:
        - buttonIdle: The button color configuration for the default, idle state
     */
    public init(buttonIdle: ButtonColor){
        self.init()
        self.buttonIdle = buttonIdle
    }
    /**
     - parameters:
        - buttonAllowed: The button color configuration for the highlighted, allowed state
     */
    public init(buttonAllowed: ButtonColor){
        self.init()
        self.buttonAllowed = buttonAllowed
    }
    /**
     - parameters:
        - buttonDenied: The button color configuration for the user explicitly denied state
     */
    public init(buttonDenied: ButtonColor){
        self.init()
        self.buttonDenied = buttonDenied
    }
    
    public init(primaryColor: Color?=nil, tertiaryColor: Color?=nil){
        self.primaryColor = primaryColor ?? Color(.systemBlue)
        self.tertiaryColor = tertiaryColor ?? Color(.systemRed)
        self.buttonIdle = ButtonColor(foregroundColor: self.primaryColor,
                                      backgroundColor: Color(.systemGray5))
        self.buttonAllowed = ButtonColor(foregroundColor: Color(.white),
                                         backgroundColor: self.primaryColor)
        self.buttonDenied = ButtonColor(foregroundColor: Color(.white),
                                        backgroundColor: self.tertiaryColor)
    }
    
    //MARK: Button Color States
    
    var primaryColor: Color
    var tertiaryColor: Color
    ///The button color configuration under idle status defined by a `ButtonColor` struct
    public var buttonIdle: ButtonColor
    ///The button color configuration under allowed status defined by a `ButtonColor` struct
    public var buttonAllowed: ButtonColor
    ///The button color configuration under denied status defined by a `ButtonColor` struct
    public var buttonDenied: ButtonColor
}

/**
 `ButtonColor` represents the color configuration for the allow button in a single state
  
  Declared within parent struct  `AllButtonColors` and should only be used within a `AllButtonColors` struct instance.
  To customize
 */
public struct ButtonColor{
    // MARK: Creating New Button Color
    /**
     - parameters:
        - foregroundColor: The color of type `Color` for the foreground text
        - backgroundColor: The color of type `Color` for the background
     */
    public init(foregroundColor: Color, backgroundColor: Color){
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    //MARK: Properties
    ///The color of type `Color` for the foreground text
    public var foregroundColor: Color
    ///The color of type `Color` for the foreground text
    public var backgroundColor: Color

}
