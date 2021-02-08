//
//  SwiftUIView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct Permissions: ViewModifier {
    var showModal: Binding<Bool>

    init(showModal:Binding<Bool>){
        self.showModal = showModal
    }

    func body(content: Content) -> some View {
        MainView(for: AnyView(content), show: showModal)
    }
}

public extension View {
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This view will show a PermissionsSwiftUI modal with 3 different permissions.
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
     - Returns:
        Returns a new view. Will show a modal that will overlay your existing view to show PermissionsSwiftUI permission handling components.
     
     */
    
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionType]) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        return self.modifier(Permissions(showModal: showModal))
    }
    /**
     Displays a PermissionsSwiftUI modal view that displays and handles permissions.
     
     For example, use this modifier on your existing view and pass in a SwiftUI Binding boolean variable. This view will show a PermissionsSwiftUI modal with 3 different permissions.
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
    
    func JMPermissions(showModal: Binding<Bool>, for permissions: [PermissionType], onAppear: @escaping ()->Void, onDisappear: @escaping ()->Void) -> some View {
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: permissions)
        PermissionStore.shared.updateStore(property: {$0.onAppear=$1}, value: onAppear)
        PermissionStore.shared.updateStore(property: {$0.onDisappear=$1}, value: onDisappear)
        return self.modifier(Permissions(showModal: showModal))
    }
}
