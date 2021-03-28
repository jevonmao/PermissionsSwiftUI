//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/18/21.
//

import Foundation
import SwiftUI

@available(iOS, obsoleted: 15.0, deprecated, message: "Access the properties through PermissionStore's configStore property instead")
/**
 Additional configuration properties for backward compatibility
 
 - Warning: These properties are deprecated, access the sub-properties through `PermissionStore` 's `configStore` property instead
 */
public extension PermissionStore {
    
    //MARK: Configuring View Texts
    ///The text for text label components, including header and descriptions
    var mainTexts: MainTexts {
        get {configStore.mainTexts}
        set {configStore.mainTexts = newValue}
    }
    
    //MARK: Customizing Colors
    ///The color configuration for permission allow buttons
    var allButtonColors: AllButtonColors {
        get {configStore.allButtonColors}
        set {configStore.allButtonColors = newValue}
    }
    
    //MARK: Change Auto Dismiss Behaviors
    ///Whether to auto dismiss the modal after last permission is allowed
    var autoDismissModal: Bool {
        get {configStore.autoDismiss}
        set {configStore.autoDismiss = newValue}
    }
    
    ///Whether to auto dismiss the alert after last permission is allowed
    var autoDismissAlert: Bool {
        get {configStore.autoDismiss}
        set {configStore.autoDismiss = newValue}
    }
    
    //MARK: Configure Auto Authorization Checking
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    var autoCheckModalAuth: Bool {
        get {configStore.autoCheckAuth}
        set {configStore.autoCheckAuth = newValue}
    }

    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    var autoCheckAlertAuth: Bool  {
        get {configStore.autoCheckAuth}
        set {configStore.autoCheckAuth = newValue}
    }
    
    //MARK: Prevent Dismissal Before All Permissions Interacted
    ///Whether to prevent dismissal of modal view before all permissions have been interacted (explict deny or allow)
    var restrictModalDismissal: Bool {
        get {configStore.restrictDismissal}
        set {configStore.restrictDismissal = newValue}
    }
    ///Whether to prevent dismissal of alert view before all permissions have been interacted (explict deny or allow)
    var restrictAlertDismissal: Bool {
        get {configStore.restrictDismissal}
        set {configStore.restrictDismissal = newValue}
    }
    
    //MARK: `onAppear` and `onDisappear` Executions
    ///Override point for executing action when PermissionsSwiftUI view appears
    var onAppear: (()->Void)? {
        get {configStore.onAppear}
        set {configStore.onAppear = newValue}
    }
    ///Override point for executing action when PermissionsSwiftUI view disappears
    var onDisappear: (()->Void)? {
        get {configStore.onDisappear}
        set {configStore.onDisappear = newValue}
    }
    ///Called when PermissionsSwiftUI view disappears with additional parameters that encapsulates the results
    var onDisappearHandler: ((successPermissions, errorPermissions)->Void)? {
        get {configStore.onDisappearHandler}
        set {configStore.onDisappearHandler = newValue}
    }
}

@available(iOS, obsoleted: 15.0, deprecated, message: "Access the properties through PermissionStore 's permissionComponentsStore property instead")
/**
 Additional permission component properties for backward compatibility
 
 - Warning: These properties are deprecated, access the sub-properties through `PermissionStore` 's `permissionComponentsStore` property instead
 */
extension PermissionStore {
    //MARK: Permission Components
    ///The displayed text and image icon for the camera permission
    public var cameraPermission: JMPermission {
        get {permissionComponentsStore.cameraPermission}
        set {permissionComponentsStore.cameraPermission = newValue}
    }
    ///The displayed text and image icon for the location permission
    public var locationPermission: JMPermission {
        get {permissionComponentsStore.locationPermission}
        set {permissionComponentsStore.locationPermission = newValue}
    }
    ///The displayed text and image icon for the location always permission
    public var locationAlwaysPermission: JMPermission {
        get {permissionComponentsStore.locationAlwaysPermission}
        set {permissionComponentsStore.locationAlwaysPermission = newValue}
    }
    ///The displayed text and image icon for the photo library permission
    public var photoPermission: JMPermission {
        get {permissionComponentsStore.photoPermission}
        set {permissionComponentsStore.photoPermission = newValue}
    }
    ///The displayed text and image icon for the microphone permission
    public var microphonePermisson: JMPermission {
        get {permissionComponentsStore.microphonePermisson}
        set {permissionComponentsStore.microphonePermisson = newValue}
    }
    ///The displayed text and image icon for the notification center permission
    public var notificationPermission: JMPermission {
        get {permissionComponentsStore.notificationPermission}
        set {permissionComponentsStore.notificationPermission = newValue}
    }
    ///The displayed text and image icon for the calendar permission
    public var calendarPermisson: JMPermission {
        get {permissionComponentsStore.calendarPermisson}
        set {permissionComponentsStore.calendarPermisson = newValue}
    }
    ///The displayed text and image icon for the bluetooth permission
    public var bluetoothPermission: JMPermission {
        get {permissionComponentsStore.bluetoothPermission}
        set {permissionComponentsStore.bluetoothPermission = newValue}
    }
    ///The displayed text and image icon for the permission to track across apps and websites
    public var trackingPermission : JMPermission {
        get {permissionComponentsStore.trackingPermission}
        set {permissionComponentsStore.trackingPermission = newValue}
    }
    ///The displayed text and image icon for the contact permission
    public var contactsPermission: JMPermission {
        get {permissionComponentsStore.contactsPermission}
        set {permissionComponentsStore.contactsPermission = newValue}
    }
    ///The displayed text and image icon for the motion permission
    public var motionPermission: JMPermission {
        get {permissionComponentsStore.motionPermission}
        set {permissionComponentsStore.motionPermission = newValue}
    }
    ///The displayed text and image icon for the reminders permission
    public var remindersPermission: JMPermission {
        get {permissionComponentsStore.remindersPermission}
        set {permissionComponentsStore.remindersPermission = newValue}
    }
    ///The displayed text and image icon for the speech recognition permission
    public var speechPermission: JMPermission {
        get {permissionComponentsStore.speechPermission}
        set {permissionComponentsStore.speechPermission = newValue}
    }
    ///The displayed text and image icon for the health permission
    public var healthPermission: JMPermission {
        get {permissionComponentsStore.healthPermission}
        set {permissionComponentsStore.healthPermission = newValue}
    }
}
