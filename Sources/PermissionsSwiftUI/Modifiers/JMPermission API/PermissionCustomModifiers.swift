//
//  PermissionCustomizeModifiers.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import SwiftUI

//MARK: Customize Permission Components
public extension View{
    /**
     Customizes the image view, title (optional), and description (optional) of any permission component

     Use this modifier on your existing view to set all the available customizations–the symbol image , and title (optional) and description (optional).

     For example,
     ```
     YourTopLevelView()
     .setPermissionComponents(for: .camera,
                              image: AnyView(Image(systemName: "camera.fill")),
                              title: "Camera",
                              description: "Camera description")
     ```
     will override the default image, title , and description for the `camera` permission. It will result in a camera image symbol, and the custom title and description
     - Parameters:
        - for: `PermissonType` specifying the permission component
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func setPermissionComponent(for permission: PermissionType, image:AnyView, title: String?=nil, description: String?=nil) -> some View{
        var permission = permission
        let currentPermission = permission.currentPermission
        permission.currentPermission = JMPermission(
            imageIcon: image,
            title: title ?? currentPermission.title,
            description: description ?? currentPermission.description, authorized: currentPermission.authorized
        )
        return self
    }
    
    /**
     Customizes only the title of any permission component

     Use this modifier on your existing view to set the title customization.

     For example,
     ```
     YourTopLevelView()
     .setPermissionComponents(for: .camera,
                              title: "Camera")
     ```
     will override the default title for the `camera` permission. It will result in a custom title.
     - Parameters:
        - for: `PermissonType` specifying the permission component
        - title: The title text
     */
    
    func setPermissionComponent(for permission: PermissionType, title: String) -> some View{
        var permission = permission
        let currentPermission = permission.currentPermission
        permission.currentPermission = JMPermission(
            imageIcon: currentPermission.imageIcon,
            title: title,
            description: currentPermission.description, authorized: currentPermission.authorized
        )
        return self
    }
    
    /**
     Customizes only the description of any permission component

     Use this modifier on your existing view to set the description customization.

     For example,
     ```
     YourTopLevelView()
     .setPermissionComponents(for: .camera,
                              description: "Camera description")
     ```
     will override the default title for the `camera` permission. It will result in a custom description.
     - Parameters:
        - for: `PermissonType` specifying the permission component
        - description: The description text
     */
    
    func setPermissionComponent(for permission: PermissionType, description: String) -> some View{
        var permission = permission
        let currentPermission = permission.currentPermission
        permission.currentPermission = JMPermission(
            imageIcon: currentPermission.imageIcon,
            title: currentPermission.title,
            description: description, authorized: currentPermission.authorized
        )
        return self
    }
}

//MARK: Configure Allow Button Colors
public extension View {
    /**
     Customizes the color of allow buttons for all status states

     The customization of button colors with this modifier applies to both `JMAlert` and `JMModal` views
     
     To customize button colors:
     1. Define a new instance of the `AllButtonColors` struct
     2. Add the `setAllowButtonColor(to colors:AllButtonColors)` modifier to your view
     3. Pass in the `AllButtonColors` struct previously into the proper parameter
     
     - Parameters:
        - for: `PermissonType` specifying the permission component
        - description: The description text
     */
    
    func setAllowButtonColor(to colors:AllButtonColors) -> some View {
        PermissionStore.shared.updateStore(property: {$0.allButtonColors=$1}, value: colors)
        return self
    }
}

//MARK: Set Overall Accent Color
public extension View {
    /**
     Customizes the overall accent color of PermissionsSwiftUI views.

     The customization of accent color with this modifier applies to both `JMAlert` and `JMModal` views. The new accent color will replace the default Apple system blue color for image icons, as well as button foreground and background colors.
     
     - Parameters:
        - to: The new customized accent color
     */
    
    func setAccentColor(to color: Color) -> some View {
        let buttonColors = AllButtonColors(primaryColor: color)
        PermissionStore.shared.updateStore(property: {$0.allButtonColors=$1}, value: buttonColors)
        return self
    }
    
    /**
     Customizes the primary and tertiary color of PermissionsSwiftUI views.

     The customization of colors with this modifier applies to both `JMAlert` and `JMModal` views.
     * The new primary color will replace the default Apple system blue color for image icons, as well as button foreground and background colors.
     * The new tertiary color will replace the default Apple system red color for the `Denied` state of buttons.
     
     - Parameters:
        - toPrimary: The new customized primary color
        - toTertiary: The new customized tertiary color
        
     */
    
    func setAccentColor(toPrimary primaryColor: Color, toTertiary tertiaryColor: Color) -> some View {
        let buttonColors = AllButtonColors(primaryColor: primaryColor,
                                           tertiaryColor: tertiaryColor)
        PermissionStore.shared.updateStore(property: {$0.allButtonColors=$1}, value: buttonColors)
        return self
    }
}
