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
// MARK: Color scheme

//private extension View {
//    func setPermissionColor(to color:Color) -> some View{
//        print(PermissionModel.PermissionModelStore.permissions)
//        for i in PermissionModel.PermissionModelStore.permissions.indices{
//            PermissionModel.PermissionModelStore.permissions[i].currentPermission.imageIcon = AnyView(PermissionModel.PermissionModelStore.permissions[i].currentPermission.imageIcon.foregroundColor(color))
//        }
//        return self.modifier(PlaceholderModifier())
//    }
//}
// MARK: Camera

public extension View {
    /**
     Customizes the image icon for camera permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     For example,
     ```
     customizeCameraPermissionWith(color:Image(systemName: "camera.fill"),
                                   title: "Camera",
                                   description: "Camera description")
     ```
     will result in a camera image symbol, and the custom title and description
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizeCameraPermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.cameraPermission.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.cameraPermission.description = description
        }
        PermissionModel.PermissionModelStore.cameraPermission.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
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
                 .customizeCameraPermissionWith(title: "Camcorder", description: "Allow to use the camera to film")
             }
             
         }
     ````
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizeCameraPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.cameraPermission.title = title
        PermissionModel.PermissionModelStore.cameraPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for camera permission component

     - Parameters:
        - title: The title text
     */
    
    func customizeCameraPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.cameraPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for camera permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizeCameraPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.cameraPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Location

public extension View {
    /**
     Customizes the image icon for location permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizeLocationPermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.locationPermission.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.locationPermission.description = description
        }
        PermissionModel.PermissionModelStore.locationPermission.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
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
                 .customizeLocationPermissionWith(title: "Camcorder", description: "Allow to use the camera to film")
             }
             
         }
     ````
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizeLocationPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.locationPermission.title = title
        PermissionModel.PermissionModelStore.locationPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for location permission component

     - Parameters:
        - title: The title text
     */
    
    func customizeLocationPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.locationPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for location permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizeLocationPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.locationPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Calendar

public extension View {
    /**
     Customizes the image icon for calendar permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizeCalendarPermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.calendarPermisson.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.calendarPermisson.description = description
        }
        PermissionModel.PermissionModelStore.calendarPermisson.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
    /**
     Customizes the title and description text for calendar permission component
     
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
                 .customizeCalendarPermissionWith(title: "System Calendar", description: "Allow to read and write the calendar")
             }
             
         }
     ````
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizeCalendarPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.calendarPermisson.title = title
        PermissionModel.PermissionModelStore.calendarPermisson.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for calendar permission component

     - Parameters:
        - title: The title text
     */
    
    func customizeCalendarPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.calendarPermisson.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for calendar permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizeCalendarPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.calendarPermisson.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Bluetooth

public extension View {
    /**
     Customizes the image icon for Bluetooth permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizeBluetoothPermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.bluetoothPermission.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.bluetoothPermission.description = description
        }
        PermissionModel.PermissionModelStore.bluetoothPermission.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
    /**
     Customizes the title and description text for Bluetooth permission component
     
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizeBluetoothPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.bluetoothPermission.title = title
        PermissionModel.PermissionModelStore.bluetoothPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for Bluetooth permission component

     - Parameters:
        - title: The title text
     */
    
    func customizeBluetoothPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.bluetoothPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for Bluetooth permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizeBluetoothPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.bluetoothPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Microphone

public extension View {
    /**
     Customizes the image icon for microphone permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizeMicrophonePermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.microphonePermisson.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.microphonePermisson.description = description
        }
        PermissionModel.PermissionModelStore.microphonePermisson.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
    /**
     Customizes the title and description text for microphone permission component
     
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizeMicPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.microphonePermisson.title = title
        PermissionModel.PermissionModelStore.microphonePermisson.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for microphone permission component

     - Parameters:
        - title: The title text
     */
    
    func customizeMicPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.microphonePermisson.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for microphone permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizeMicPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.microphonePermisson.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Notification

public extension View {
    /**
     Customizes the image icon for notification permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizeNotificationPermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.notificationPermission.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.notificationPermission.description = description
        }
        PermissionModel.PermissionModelStore.notificationPermission.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
    /**
     Customizes the title and description text for notification permission component
     
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizeNotificationPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.notificationPermission.title = title
        PermissionModel.PermissionModelStore.notificationPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for notification permission component

     - Parameters:
        - title: The title text
     */
    
    func customizeNotificationPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.notificationPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for notification permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizeNotificationPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.notificationPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}

// MARK: Photo

public extension View {
    /**
     Customizes the image icon for photo library permission component
     
     Use this modifier on your existing view to customize the symbol image , and title (optional) and description (optional).
     
     - Parameters:
        - image: The color to render the symbol image
        - title: The title text (optional)
        - description: The description text (optional)
     */
    
    func customizePhotoPermissionWith(image:Image, title: String?=nil, description: String?=nil) -> some View{
        if let title = title{
            PermissionModel.PermissionModelStore.photoPermission.title = title
        }
        if let description = description{
            PermissionModel.PermissionModelStore.photoPermission.description = description
        }
        PermissionModel.PermissionModelStore.photoPermission.imageIcon = AnyView(image)
        return self.modifier(PlaceholderModifier())
    }
    /**
     Customizes the title and description text for the photo library permission component
     
     - Parameters:
        - title: The title text
        - description: The description text
     */
    
    func customizePhotoPermissionWith(title: String, description: String) -> some View {
        PermissionModel.PermissionModelStore.photoPermission.title = title
        PermissionModel.PermissionModelStore.photoPermission.description = description
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the title text for the photo library permission component

     - Parameters:
        - title: The title text
     */
    
    func customizePhotoPermissionWith(title: String) -> some View {
        PermissionModel.PermissionModelStore.photoPermission.title = title
        return self.modifier(PlaceholderModifier())
    }

    /**
     Customizes only the description text for the photo library permission component
     
     - Parameters:
        - description: The description text
     */
    
    func customizePhotoPermissionWith(description: String) -> some View {
        PermissionModel.PermissionModelStore.photoPermission.description = description
        return self.modifier(PlaceholderModifier())
    }
}
