//
//  ConfigStore.swift
//  
//
//  Created by Jevon Mao on 3/18/21.
//

import Foundation

/**
 The data storage class that contains configurable settings
 */
public struct ConfigStore {
    //MARK: Creating a new configuration store
    ///Creates a new configuration store with default settings
    public init(){}
    //MARK: Configuring View Texts
    ///The text for text label components, including header and descriptions
    public var mainTexts = MainTexts()
    
    //MARK: Customizing Colors
    ///The color configuration for permission allow buttons
    public var allButtonColors = AllButtonColors()
    
    //MARK: Change Auto Dismiss Behaviors
    ///Whether to auto dismiss the view after last permission is allowed
    public var autoDismiss: Bool = true

    @available(iOS, deprecated, obsoleted: 15, renamed: "autoDismiss")
    ///Whether to auto dismiss the modal after last permission is allowed
    public var autoDismissModal: Bool = true
    
    @available(iOS, deprecated, obsoleted: 15, renamed: "autoDismiss")
    ///Whether to auto dismiss the alert after last permission is allowed
    public var autoDismissAlert: Bool = true
    
    //MARK: Configure Auto Authorization Checking
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    public var autoCheckAuth: Bool = true

    @available(iOS, deprecated, obsoleted: 15, renamed: "autoDismiss")
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    public var autoCheckModalAuth: Bool = true
    @available(iOS, deprecated, obsoleted: 15, renamed: "autoDismiss")
    ///Whether to auto check for authorization status before showing, and show the view only if permission is in `notDetermined`
    public var autoCheckAlertAuth: Bool = true
    
    //MARK: Prevent Dismissal Before All Permissions Interacted
    ///Whether to prevent dismissal of  view before all permissions have been interacted (explict deny or allow)
    public var restrictDismissal: Bool = true
    @available(iOS, deprecated, obsoleted: 15, renamed: "restrictDismissal")
    ///Whether to prevent dismissal of modal view before all permissions have been interacted (explict deny or allow)
    public var restrictModalDismissal: Bool = true
    @available(iOS, deprecated, obsoleted: 15, renamed: "restrictDismissal")
    ///Whether to prevent dismissal of alert view before all permissions have been interacted (explict deny or allow)
    public var restrictAlertDismissal: Bool = true
    
    //MARK: `onAppear` and `onDisappear` Executions
    ///Override point for executing action when PermissionsSwiftUI view appears
    public var onAppear: (()->Void)?
    ///Override point for executing action when PermissionsSwiftUI view disappears
    public var onDisappear: (()->Void)?
    ///Called when PermissionsSwiftUI view disappears with additional parameters that encapsulates the results
    public var onDisappearHandler: ((successPermissions, errorPermissions)->Void)?
}

/**
 Encapsulates the surrounding texts and title
 */
public struct MainTexts: Equatable {
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
