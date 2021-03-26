//
//  MainModifiers.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

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
    @inlinable func JMModal(showModal: Binding<Bool>, for permissions: [PermissionType]) -> some View {
        #warning("Reference JMAlert modifiers, fix this here.")
        return initializeJMModal(showModal: showModal, for: permissions)
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
    @inlinable func JMModal(showModal: Binding<Bool>, for permissions: [PermissionType], restrictDismissal: Bool) -> some View {
        initializeJMModal(showModal: showModal, for: permissions, restrictDismissal: restrictDismissal)
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
    @inlinable func JMModal(showModal: Binding<Bool>, withConfig model: PermissionStore) -> some View {
        ModalMainView(for: self, showing: showModal).withEnvironmentObjects(store: model, permissionStyle: .modal)
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
    @inlinable func JMModal(showModal: Binding<Bool>, for permissions: [PermissionType], autoDismiss: Bool) -> some View {
        initializeJMModal(showModal: showModal, for: permissions, autoDismiss: autoDismiss)
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
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil) -> some View {
        initializeJMModal(showModal: showModal, for: permissions, autoDismiss: autoDismiss, autoCheckAuthorization: autoCheckAuthorization)
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
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 restrictDismissal: Bool?=nil) -> some View {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          autoDismiss: autoDismiss,
                          autoCheckAuthorization: autoCheckAuthorization,
                          restrictDismissal: restrictDismissal)
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
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 onAppear: @escaping () -> Void,
                 onDisappear: @escaping () -> Void) -> some View {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          onAppear: onAppear,
                          onDisappear: onDisappear)
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
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 onAppear: @escaping () -> Void,
                 _ onDisappearHandler: @escaping (successPermissions, errorPermissions) -> Void) -> some View {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          onAppear: onAppear,
                          onDisappearHandler: onDisappearHandler) 
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
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionType],
                 autoDismiss: Bool,
                 onAppear: @escaping () -> Void,
                 onDisappear: @escaping () -> Void) -> some View {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          autoDismiss: autoDismiss,
                          onAppear: onAppear,
                          onDisappear: onDisappear)
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
    @inlinable func JMModal(showModal: Binding<Bool>,
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
    @inlinable func JMModal(showModal: Binding<Bool>,
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
    }
    @usableFromInline internal func initializeJMModal(showModal: Binding<Bool>,
                         for permissions: [PermissionType]?=nil,
                         autoDismiss: Bool?=nil,
                         autoCheckAuthorization: Bool?=nil,
                         restrictDismissal: Bool?=nil,
                         onAppear: (() -> Void)?=nil,
                         onDisappear: (() -> Void)?=nil,
                         onDisappearHandler: ((successPermissions, errorPermissions) -> Void)?=nil) -> some View {
        let store = PermissionStore()
        store.permissions = permissions ?? []
        store.configStore.onAppear = onAppear
        store.configStore.onDisappear = onDisappear
        store.configStore.autoDismiss = autoDismiss ?? true
        store.configStore.autoCheckAuth = autoCheckAuthorization ?? true
        store.configStore.restrictDismissal = restrictDismissal ?? true
        store.configStore.onDisappearHandler = onDisappearHandler
        return ModalMainView(for: self, showing: showModal).withEnvironmentObjects(store: store, permissionStyle: .modal)


    }
    
}

//MARK: - Showing Alert Style Permissions
public extension View {
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
    
    func JMAlert(showModal: Binding<Bool>, for permissions: [PermissionType]) -> some View {
        initializeJMAlert(showModal: showModal, for: permissions)
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
        initializeJMAlert(showModal: showModal, for: permissions, autoDismiss: autoDismiss)
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
        initializeJMAlert(showModal: showModal, for: permissions, autoCheckAuthorization: autoCheckAuthorization)
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
        initializeJMAlert(showModal: showModal, for: permissions, autoDismiss: autoDismiss, autoCheckAuthorization: autoCheckAuthorization)
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
        initializeJMAlert(showModal: showModal, for: permissions, onAppear: onAppear, onDisappear: onDisappear)
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
        initializeJMAlert(showModal: showModal, for: permissions, autoDismiss: autoDismiss, onAppear: onAppear, onDisappear: onDisappear)
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
        initializeJMAlert(showModal: showModal, for: permissions, autoDismiss: autoDismiss, autoCheckAuthorization: autoCheckAuthorization, onAppear: onAppear, onDisappear: onDisappear)
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
        AlertMainView(for: self, showing: showModal).environmentObject(model)
    }
    
    private func initializeJMAlert(showModal: Binding<Bool>,
                                   for permissions: [PermissionType]?=nil,
                                autoDismiss: Bool?=nil,
                                autoCheckAuthorization: Bool?=nil,
                                restrictDismissal: Bool?=nil,
                                onAppear: (() -> Void)?=nil,
                                onDisappear: (() -> Void)?=nil,
                                onDisappearHandler: ((successPermissions, errorPermissions) -> Void)?=nil) -> some View {
        let store = PermissionStore()
        store.permissions = permissions ?? []
        store.configStore.onAppear = onAppear
        store.configStore.onDisappear = onDisappear
        store.configStore.autoDismiss = autoDismiss ?? true
        store.configStore.autoCheckAuth = autoCheckAuthorization ?? true
        store.configStore.restrictDismissal = restrictDismissal ?? true
        store.configStore.onDisappearHandler = onDisappearHandler
        return AlertMainView(for: self, showing: showModal).withEnvironmentObjects(store: store, permissionStyle: .modal)
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
        initializeJMModal(showModal: showModal, for: permissions)
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
        initializeJMModal(showModal: showModal, for: permissions, autoDismiss: autoDismiss)
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
        initializeJMModal(showModal: showModal, for: permissions, onAppear: onAppear, onDisappear: onDisappear)
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
        initializeJMModal(showModal: showModal, for: permissions, onAppear: onAppear, onDisappear: onDisappear)
    }
}

extension View {
    @usableFromInline func withEnvironmentObjects(store: PermissionStore, permissionStyle: PermissionViewStyle) -> some View {
        self
            .environmentObject(store)
            .environmentObject(PermissionSchemaStore(configStore: store.configStore,
                                                     permissions: store.permissions,
                                                     permissionComponentsStore: store.permissionComponentsStore,
                                                     permissionViewStyle: permissionStyle))
    }
}
