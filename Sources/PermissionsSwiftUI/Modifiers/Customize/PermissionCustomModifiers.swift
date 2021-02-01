//
//  PermissionCustomizeModifiers.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import SwiftUI

struct PlaceholderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}

// MARK: Camera

public extension View {
    /**
     Customizes the title and description text for camera permission component
     
     For example, use this modifier on your existing view and pass in your custom text to show
     ````
         struct ContentView: View {
             @State var showModal = false
             var body: some View {
                 Button(action: {
                     showModal=true
                 }, label: {
                     Text("Ask user for permissions")
                 })
                 .JMPermissions(showModal: $showModal, for: [.locationAlways, .photo, .microphone])
                 .permissionCamera(title: "Camcorder", description: "Allow to use the camera to film")
             }
             
         }
     ````
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func permissionCamera(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.cameraPermission.title = title
        PermissionModel.PermissionModelStore.cameraPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for camera permission component

     - Parameters:
        - title: The title text
     */
    
    func permissionCamera(title: String) -> some View {
        PermissionModel.PermissionModelStore.cameraPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for camera permission component
     
     - Parameters:
        - description: The description text
     */
    
    func permissionCamera(description: String) -> some View {
        PermissionModel.PermissionModelStore.cameraPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Location

public extension View {
    /**
     Customizes the title and description text for location permission component
     
     For example, use this modifier on your existing view and pass in your custom text to show
     ````
         struct ContentView: View {
             @State var showModal = false
             var body: some View {
                 Button(action: {
                     showModal=true
                 }, label: {
                     Text("Ask user for permissions")
                 })
                 .JMPermissions(showModal: $showModal, for: [.locationAlways, .photo, .microphone])
                 .permissionLocation(title: "Camcorder", description: "Allow to use the camera to film")
             }
             
         }
     ````
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func permissionLocation(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.locationPermission.title = title
        PermissionModel.PermissionModelStore.locationPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for location permission component

     ````
     - Parameters:
        - title: The title text
     */
    
    func permissionLocation(title: String) -> some View {
        PermissionModel.PermissionModelStore.locationPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for location permission component
     
     - Parameters:
        - description: The description text
     */
    
    func permissionLocation(description: String) -> some View {
        PermissionModel.PermissionModelStore.locationPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}
