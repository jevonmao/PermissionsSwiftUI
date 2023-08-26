//
//  File.swift
//  
//
//  Created by Jevon Mao on 4/6/21.
//

import SwiftUI

//MARK: - Showing Modal Style Permissions
@available(iOS 13.0, tvOS 13.0, *)
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
    @inlinable func JMModal(showModal: Binding<Bool>, for permissions: [PermissionManager]) -> some CustomizableView {
         initializeJMModal(showModal: showModal, for: permissions)
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
    @inlinable func JMModal(showModal: Binding<Bool>, for permissions: [PermissionManager], restrictDismissal: Bool) -> some CustomizableView {
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
    @inlinable func JMModal(showModal: Binding<Bool>, withConfig model: PermissionStore) -> some CustomizableView {
        ModalViewWrapper(for: self, showing: showModal, store: model)
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
    @inlinable func JMModal(showModal: Binding<Bool>, for permissions: [PermissionManager], autoDismiss: Bool) -> some CustomizableView {
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
                 for permissions: [PermissionManager],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil) -> some CustomizableView {
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
                 for permissions: [PermissionManager],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 restrictDismissal: Bool?=nil) -> some CustomizableView {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          autoDismiss: autoDismiss,
                          autoCheckAuthorization: autoCheckAuthorization,
                          restrictDismissal: restrictDismissal)
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - onAppear: Override point for when the modal appears
        - onDisappear: Override point for when the modal modal disappears
        - onDisappearHandler: Returns back results of permission request when the modal dismissess
        - successful:  Permissions that are successfully requested and granted. Will return nil if no permissions are successful.
        - erroneous: Permissions that failed with error while requesting, or explicitly denied. Will return nil if all permissions are successful.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionManager],
                 onAppear: @escaping () -> Void,
                 onDisappear: (() -> Void)?=nil,
                 onDisappearHandler: Optional<(_ successful: [JMResult]?, _ erroneous: [JMResult]?) -> Void>=nil) -> some CustomizableView {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          onAppear: onAppear,
                          onDisappear: onDisappear,
                          onDisappearHandler: onDisappearHandler)
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     ````
     - Parameters:
       - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - onAppear: Override point for when the modal appears
        - onDisappear: Override point for when the modal modal disappears
        - onDisappearHandler: Returns back results of permission request when the modal dismissess
        - successful:  Permissions that are successfully requested and granted. Will return nil if no permissions are successful.
        - erroneous: Permissions that failed with error while requesting, or explicitly denied. Will return nil if all permissions are successful.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionManager],
                 autoDismiss: Bool,
                 onAppear: @escaping () -> Void,
                 onDisappear: (() -> Void)?=nil,
                 onDisappearHandler: Optional<(_ successful: [JMResult]?, _ erroneous: [JMResult]?) -> Void>=nil) -> some CustomizableView {
        initializeJMModal(showModal: showModal,
                          for: permissions,
                          autoDismiss: autoDismiss,
                          onAppear: onAppear,
                          onDisappear: onDisappear,
                          onDisappearHandler: onDisappearHandler)
    }
    
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - restrictDismissal: Specify whether to prevent dismissal of modal view before all permissions have been interacted. Default is `true`.
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - onAppear: Override point for when the modal appears
        - onDisappear: Override point for when the modal modal disappears
        - onDisappearHandler: Returns back results of permission request when the modal dismissess
        - successful:  Permissions that are successfully requested and granted. Will return nil if no permissions are successful.
        - erroneous: Permissions that failed with error while requesting, or explicitly denied. Will return nil if all permissions are successful.
     - Note:
        The `autoDismiss` feature currently will not auto dismiss if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionManager],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 onAppear: @escaping () -> Void,
                 onDisappear: (() -> Void)?=nil,
                 onDisappearHandler: Optional<(_ successful: [JMResult]?, _ erroneous: [JMResult]?) -> Void>=nil) -> some CustomizableView {
        initializeJMModal(showModal: showModal,
                       for: permissions,
                       autoDismiss: autoDismiss,
                       autoCheckAuthorization: autoCheckAuthorization,
                       onAppear: onAppear,
                       onDisappear: onDisappear,
                       onDisappearHandler: onDisappearHandler)
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - onAppear: Override point for when the modal appears
        - onDisappear: Override point for when the modal modal disappears
        - onDisappearHandler: Returns back results of permission request when the modal dismissess
        - successful:  Permissions that are successfully requested and granted. Will return nil if no permissions are successful.
        - erroneous: Permissions that failed with error while requesting, or explicitly denied. Will return nil if all permissions are successful.
     - Note:
        The `autoDismiss` feature currently will not auto dismiss, if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionManager],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 restrictDismissal: Bool?=nil,
                 onAppear: @escaping () -> Void,
                 onDisappear: (() -> Void)?=nil,
                 onDisappearHandler: Optional<(_ successful: [JMResult]?, _ erroneous: [JMResult]?) -> Void>=nil) -> some CustomizableView {
        initializeJMModal(showModal: showModal,
                for: permissions,
                autoDismiss: autoDismiss,
                autoCheckAuthorization: autoCheckAuthorization,
                restrictDismissal: restrictDismissal,
                onAppear: onAppear,
                onDisappear: onDisappear,
                onDisappearHandler: onDisappearHandler)
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.

     - Parameters:
        - showModal: A `Binding<Bool>` value to toggle show the JMPermission view
        - for: An array of type `PermissionModel` to specify permissions to show
        - autoDismiss: Specify whether to auto dismiss modal after user allowing the last item. Default is `true`
        - autoCheckAuthorization: Specify whether to auto check for authorization status before showing. The modal will seamlessly only display permission UI for permission that are in `notDetermined` status. If no permission meet the criteria, the alert will not show at all. Default is `true`
        - restrictDismissal: Specify whether to prevent dismissal of modal view before all permissions have been interacted. Default is `true`.
        - useAltButton: Whether to use the alternative "NEXT" in place of "ALLOW" for the allow button label
        - onAppear: Override point for when the modal appears
        - onDisappear: Override point for when the modal modal disappears
        - onDisappearHandler: Returns back results of permission request when the modal dismissess
        - successful:  Permissions that are successfully requested and granted. Will return nil if no permissions are successful.
        - erroneous: Permissions that failed with error while requesting, or explicitly denied. Will return nil if all permissions are successful.
     - Note:
        The `autoDismiss` feature currently will not auto dismiss, if the user has not allowed all permissions. If the user denied or ignored some permissions, the modal or alert will not auto dismiss. This encourages the user to go to settings and manually re-allow denied permissions.
        The `authCheckAuthorization` is highly recommended for best user experience.
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.

     */
    @inlinable func JMModal(showModal: Binding<Bool>,
                 for permissions: [PermissionManager],
                 autoDismiss: Bool?=nil,
                 autoCheckAuthorization: Bool?=nil,
                 restrictDismissal: Bool?=nil,
                 useAltButton: Bool? = nil,
                 onAppear: (() -> Void)?=nil,
                 onDisappear: (() -> Void)?=nil,
                 onDisappearHandler: Optional<(_ successful: [JMResult]?, _ erroneous: [JMResult]?) -> Void>=nil) -> some CustomizableView {
        initializeJMModal(showModal: showModal,
                for: permissions,
                autoDismiss: autoDismiss,
                autoCheckAuthorization: autoCheckAuthorization,
                restrictDismissal: restrictDismissal,
                useAltButton: useAltButton,
                onAppear: onAppear,
                onDisappear: onDisappear,
                onDisappearHandler: onDisappearHandler)
    }
    @usableFromInline internal func initializeJMModal(showModal: Binding<Bool>,
                         for permissions: [PermissionManager]?=nil,
                         autoDismiss: Bool?=nil,
                         autoCheckAuthorization: Bool?=nil,
                         restrictDismissal: Bool?=nil,
                         useAltButton: Bool?=nil,
                         onAppear: (() -> Void)?=nil,
                         onDisappear: (() -> Void)?=nil,
                         onDisappearHandler: (([JMResult]?, [JMResult]?) -> Void)?=nil) -> some CustomizableView {
        let store = PermissionStore()
        store.permissions = permissions ?? []
        store.configStore.onAppear = onAppear
        store.configStore.onDisappear = onDisappear
        store.configStore.autoDismiss = autoDismiss ?? false
        store.configStore.autoCheckAuth = autoCheckAuthorization ?? true
        store.configStore.restrictDismissal = restrictDismissal ?? true
        store.configStore.onDisappearHandler = onDisappearHandler
        store.configStore.mainTexts.useAltButtonLabel = useAltButton ?? false
        return ModalViewWrapper(for: self, showing: showModal, store: store)


    }
    
}

//MARK: - Deprecated
@available(iOS 13.0, tvOS 13.0, *)
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
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionManager]) -> some View {
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
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionManager], autoDismiss: Bool) -> some View {
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
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionManager], onAppear: @escaping () -> Void, onDisappear: @escaping () -> Void) -> some View {
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
                       for permissions: [PermissionManager],
                       autoDismiss: Bool,
                       onAppear: @escaping () -> Void,
                       onDisappear: @escaping () -> Void) -> some View {
        initializeJMModal(showModal: showModal, for: permissions, onAppear: onAppear, onDisappear: onDisappear)
    }
}
