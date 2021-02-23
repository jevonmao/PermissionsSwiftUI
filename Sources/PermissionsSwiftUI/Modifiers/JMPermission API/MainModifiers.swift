//
//  MainModifiers.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

// MARK: Modal Style permissions
struct PermissionsModal: ViewModifier {
    var showModal: Binding<Bool>

    init(showModal:Binding<Bool>){
        self.showModal = showModal
    }

    func body(content: Content) -> some View {
        return MainView(for: AnyView(content), show: showModal)

    }
}

//MARK: - Modal Style Permissions
public extension View {
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This example view will show a PermissionsSwiftUI modal with 3 different permissions.
     ````
         struct ContentView: View {
             @State var showModal = false
             var body: some View {
                 Button(action: {
                     showModal=true
                 }, label: {
                     Text("Ask user for permissions")
                 })
                 .JMModal(showModal: $showModal, for: [.locationAlways, .photo, .microphone])
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>, for permissions: [PermissionType]) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, declare an instance of type `PermissionStore` to configure data that is reflected on the UI components. Use this modifier on your existing view and pass in the previously declared model object.
     ````
         struct ContentView: View {
             @State var showModal = false
             var model: PermissionStore {
                 var model = PermissionStore()
                 model.permissions = [.camera, .calendar, .location]
                 model.mainTexts.headerText = "Some title"
                 return model
             }
             var body: some View {
                 YourView()
                 .JMModal(showModal: $showModal, withConfig: model)
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - withConfig: A data model of type `PermissionStore` to configure PermissionsSwiftUI's UI view
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>, withConfig model: PermissionStore) -> some View {
        PermissionStore.shared.updateStore(property: {$0=$1}, value: model)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>, for permissions: [PermissionType], autoDismiss: Bool) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The alert will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
     - Note:
        The `autoDismiss` feature currently will not auto dismiss, if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss ?? true)
        PermissionStore.shared.updateStore(property: {$0.autoCheckModalAuth=$1}, value: autoCheckAuthorization ?? true)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This example view will show a PermissionsSwiftUI modal with 3 different permissions.
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
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 onAppear: @escaping () -> Void,
                 onDisappear: @escaping () -> Void) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool,
                 onAppear: @escaping () -> Void,
                 onDisappear: @escaping () -> Void) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        PermissionStore.shared.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The alert will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Note:
        The `autoDismiss` feature currently will not auto dismiss, if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 onAppear: @escaping () -> Void,
                 onDisappear: @escaping () -> Void) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        PermissionStore.shared.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss ?? true)
        PermissionStore.shared.updateStore(property: {$0.autoCheckModalAuth=$1}, value: autoCheckAuthorization ?? true)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
}

//MARK: - Deprecated
public extension View {
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This example view will show a PermissionsSwiftUI modal with 3 different permissions.
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
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
     - Warning: Deprecated. The name is changed to `JMModal`
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @available(iOS, deprecated, obsoleted:15, renamed: "JMModal")
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionType]) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This example view will show a PermissionsSwiftUI modal with 3 different permissions.
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
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
     - Warning: Deprecated. The name is changed to `JMModal`
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @available(iOS, deprecated, obsoleted:15, renamed: "JMModal")
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionType], autoDismiss: Bool) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This example view will show a PermissionsSwiftUI modal with 3 different permissions.
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
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Warning: Deprecated. The name is changed to `JMModal`
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @available(iOS, deprecated, obsoleted:15, renamed: "JMModal")
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionType], onAppear: @escaping () -> Void, onDisappear: @escaping () -> Void) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        return self.modifier(PermissionsModal(showModal: showModal))
    }

    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This example view will show a PermissionsSwiftUI modal with 3 different permissions.
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
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Warning: Deprecated. The name is changed to `JMModal`
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @available(iOS, deprecated, obsoleted:15, renamed: "JMModal")
    func JMPermissions(showModal: Binding<Bool>,
                       for permissions: [PermissionType],
                       autoDismiss: Bool,
                       onAppear: @escaping () -> Void,
                       onDisappear: @escaping () -> Void) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        PermissionStore.shared.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
}

// MARK: - Alert Style permissions
struct PermissionsAlert: ViewModifier{
    var show:Binding<Bool>
    func body(content: Content) -> some View {
        AlertMainView(for: AnyView(content), show: show)
    }
}
//MARK: - Alert Style Permissions
public extension View{
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.
     ````
         struct ContentView: View {
             @State var showModal = false
             var body: some View {
                 Button(action: {
                     showModal=true
                 }, label: {
                     Text("Ask user for permissions")
                 })
                 .JMAlert(show: $showModal)
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    
    func JMAlert(showModal: Binding<Bool>, for permissions: [PermissionType]) -> some View{
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.

     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`

     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */

    func JMAlert(showModal: Binding<Bool>, for permissions: [PermissionType], autoDismiss: Bool) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.

     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The alert will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
     - Note:
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */

    func JMAlert(showModal: Binding<Bool>, for permissions: [PermissionType], autoCheckAuthorization: Bool) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: autoCheckAuthorization)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.

     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The alert will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
     - Note:
        The `autoDismiss` feature currently will not auto dismiss, if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */

    func JMAlert(showModal: Binding<Bool>, for permissions: [PermissionType], autoDismiss: Bool?=nil, autoCheckAuthorization: Bool?=nil) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss ?? true)
        PermissionStore.shared.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: autoCheckAuthorization ?? true)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    
    func JMAlert(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 onAppear: (() -> Void)?=nil,
                 onDisappear: (() -> Void)?=nil) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMAlert(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool,
                 onAppear: (() -> Void)?=nil,
                 onDisappear: (() -> Void)?=nil) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        PermissionStore.shared.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     Compared to the `JMModal` permissions, the `JMAlert` displays permissions in a pop up alert style.
     It is recommended when you have less than 3 permissions, or need a more versatile UI/UX.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable.
     This example view will show a PermissionsSwiftUI alert with 3 different permissions.
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The alert will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Note:
        The `autoDismiss` feature currently will not auto dismiss, if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMAlert(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 onAppear: (() -> Void)?=nil,
                 onDisappear: (() -> Void)?=nil) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        PermissionStore.shared.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss ?? true)
        PermissionStore.shared.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: autoCheckAuthorization ?? true)
        return self.modifier(PermissionsAlert(show: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI alert view that displays and handles permissions.
     
     For example, declare an instance of type `PermissionStore` to configure data that is reflected on the UI components. Use this modifier on your existing view and pass in the previously declared model object.
     ````
         struct ContentView: View {
             @State var showModal = false
             var model: PermissionStore {
                 var model = PermissionStore()
                 model.permissions = [.camera, .calendar, .location]
                 model.mainTexts.headerText = "Some title"
                 return model
             }
             var body: some View {
                 YourView()
                 .JMAlert(showModal: $showModal, withConfig: model)
             }
             
         }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - withConfig: A data model of type `PermissionStore` to configure PermissionsSwiftUI's UI view
     - Returns:
        Returns a new view. Will show a alert pop up that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMAlert(showModal: Binding<Bool>, withConfig model: PermissionStore) -> some View {
        PermissionStore.shared.updateStore(property: {$0=$1}, value: model)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
}
