//
//  PermissionCustomizeModifiers.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import SwiftUI

//MARK: Customize Permission Components
@available(iOS 13.0, tvOS 13.0, *)
public extension CustomizableView {
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
    
    @inlinable func setPermissionComponent(for permission: PermissionType, image:AnyView, title: String?=nil, description: String?=nil) -> some CustomizableView {
        store.permissionComponentsStore.getPermissionComponent(for: permission){permissionComponent in
            permissionComponent.title = title ?? permissionComponent.title
            permissionComponent.imageIcon = image
            permissionComponent.description = description ?? permissionComponent.description
        }
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
    
    @inlinable func setPermissionComponent(for permission: PermissionType, title: String) -> some CustomizableView {
        store.permissionComponentsStore.getPermissionComponent(for: permission){permissionComponent in
            permissionComponent.title = title
        }
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
    
    @inlinable func setPermissionComponent(for permission: PermissionType, description: String) -> some CustomizableView {
        store.permissionComponentsStore.getPermissionComponent(for: permission){$0.description = description}
        return self
    }
}

//MARK: Configure Allow Button Colors
@available(iOS 13.0, tvOS 13.0, *)
public extension CustomizableView {
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
    
    @inlinable func setAllowButtonColor(to colors:AllButtonColors) -> some CustomizableView {
        store.configStore.allButtonColors = colors
        return self
    }
}


//MARK: Set Overall Accent Color
@available(iOS 13.0, tvOS 13.0, *)
public extension CustomizableView {
    /**
     Customizes the overall accent color of PermissionsSwiftUI views.

     The customization of accent color with this modifier applies to both `JMAlert` and `JMModal` views. The new accent color will replace the default Apple system blue color for image icons, as well as button foreground and background colors.
     
     - Parameters:
        - to: The new customized accent color
     */
    
    @inlinable func setAccentColor(to color: Color) -> some CustomizableView {
        store.configStore.allButtonColors.primaryColor = color
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
    
    @inlinable func setAccentColor(toPrimary primaryColor: Color, toTertiary tertiaryColor: Color) -> some CustomizableView {
        let buttonColors = AllButtonColors(primaryColor: primaryColor,
                                           tertiaryColor: tertiaryColor)
        store.configStore.allButtonColors = buttonColors
        return self
    }

    /**
     Customizes the text foreground style for all the permission descriptions.

     - Parameters:
        - foreground: The new customized color

     */

    @inlinable func setPermissionDescription(foreground color: any ShapeStyle) -> some CustomizableView {
        store.configStore.permissionDescriptionForeground = color
        return self
    }
}

