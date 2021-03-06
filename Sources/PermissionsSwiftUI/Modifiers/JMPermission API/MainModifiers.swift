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

struct PermissionsAlert: ViewModifier{
    var showModal:Binding<Bool>
    func body(content: Content) -> some View {
        AlertMainView(for: AnyView(content), show: showModal)
    }
}

//MARK: - Showing Model Style Permissions
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
        initializeJMModal(showModal: showModal, for: permissions)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - restrictDismissal: Specify whether to prevent dismissal of modal view before all permissions have been interacted. Default is `true`.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>, for permissions: [PermissionType], restrictDismissal: Bool) -> some View {
        initializeJMModal(showModal: showModal, for: permissions, restrictDismissal: restrictDismissal)
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
        initializeJMModal(showModal: showModal, withConfig: model)
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
        initializeJMModal(showModal: showModal, for: permissions, autoDismiss: autoDismiss)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
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
        initializeJMModal(showModal: showModal, for: permissions, autoDismiss: autoDismiss, autoCheckAuthorization: autoCheckAuthorization)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - restrictDismissal: Specify whether to prevent dismissal of modal view before all permissions have been interacted. Default is `true`.
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
                 restrictDismissal: Bool?=nil) -> some View {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          autoDismiss: autoDismiss,
                          autoCheckAuthorization: autoCheckAuthorization,
                          restrictDismissal: restrictDismissal)
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
                 .JMModal(showModal: $showModal, for: [.locationAlways, .photo, .microphone])
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
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          onAppear: onAppear,
                          onDisappear: onDisappear)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     Use this modifier on your existing view, pass in the permissions to show, and handle the result in the trailing closure. The trailing closure will be called and executed when the PermissionsSwiftUI view disappears. Depending on your needs, you can perform further action with the separate `successPermissions` and `errorPermissions` which are both of type `[PermissionType: JMResult]`.
     
     For example, show a `JMModal` with camera and location permissions:
     ````
     .JMModal(showModal: $showModal, for: [.camera, .location], onAppear: {}){successPermissions, errorPermissions in
         guard errorPermissions.isEmpty else {
             print(errorResult)
             return
         }
         for permission in successPermisisons.keys{
             //Do something with the results - ex. ask user to enable denied permissions in settings
         }
     }
     ````
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - onAppear: Override point for when the JMmodal modal appears
        - onDisappearHandler: The completion handler to be called when the JMModal disappears and permission requests are finished. The handler takes the following parameters:
        - successPermissions: A dictionary object that encapsulates the authorization status and error(nil) of all successed permisisons
        - errorPermissions: A dictionary object that encapsulates the authorization status and error of all erroneous permisisons
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 onAppear: @escaping () -> Void,
                 _ onDisappearHandler: @escaping (successPermissions, errorPermissions) -> Void) -> some View {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          onAppear: onAppear,
                          onDisappearHandler: onDisappearHandler) 
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
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          autoDismiss: autoDismiss,
                          onAppear: onAppear,
                          onDisappear: onDisappear)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - restrictDismissal: Specify whether to prevent dismissal of modal view before all permissions have been interacted. Default is `true`.
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - onAppear: Override point for when JMPermission modal appears
        - onDisappear: Override point for when JMPermission modal disappears
     - Note:
        The `autoDismiss` feature currently will not auto dismiss if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
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
        initializeJMModal(showModal: showModal,
                       for: permissions,
                       autoDismiss: autoDismiss,
                       autoCheckAuthorization: autoCheckAuthorization,
                       onAppear: onAppear,
                       onDisappear: onDisappear)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
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
                 restrictDismissal: Bool?=nil,
                 onAppear: @escaping () -> Void,
                 onDisappear: @escaping () -> Void) -> some View {
        initializeJMModal(showModal: showModal,
                for: permissions,
                autoDismiss: autoDismiss,
                autoCheckAuthorization: autoCheckAuthorization,
                restrictDismissal: restrictDismissal,
                onAppear: onAppear,
                onDisappear: onDisappear)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
    private func initializeJMModal(showModal: Binding<Bool>,
                         for permissions: [PermissionType]?=nil,
                         autoDismiss: Bool?=nil,
                         autoCheckAuthorization: Bool?=nil,
                         restrictDismissal: Bool?=nil,
                         onAppear: (() -> Void)?=nil,
                         onDisappear: (() -> Void)?=nil,
                         withConfig model: PermissionStore?=nil,
                         onDisappearHandler: ((successPermissions, errorPermissions) -> Void)?=nil) {
        guard let model = model else {
            let store = PermissionStore()
            store.permissions = permissions ?? []
            store.onAppear = onAppear
            store.onDisappear = onDisappear
            store.autoDismissModal = autoDismiss ?? true
            store.autoCheckModalAuth = autoCheckAuthorization ?? true
            store.restrictModalDismissal = restrictDismissal ?? true
            store.onDisappearHandler = onDisappearHandler 
            store.updateStore(property: {$0=$1}, value: store)
            return
        }
        store.updateStore(property: {$0=$1}, value: model)

    }
    
}

//MARK: - Showing Alert Style Permissions
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: autoCheckAuthorization)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss ?? true)
        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: autoCheckAuthorization ?? true)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        store.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        store.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        store.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        store.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        store.updateStore(property: {$0.autoDismissAlert=$1}, value: autoDismiss ?? true)
        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: autoCheckAuthorization ?? true)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0=$1}, value: model)
        return self.modifier(PermissionsAlert(showModal: showModal))
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss)
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        store.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
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
        store.updateStore(property: {$0.permissions=$1}, value: permissions)
        store.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        store.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        store.updateStore(property: {$0.autoDismissModal=$1}, value: autoDismiss)
        return self.modifier(PermissionsModal(showModal: showModal))
    }
}
