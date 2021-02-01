//
//  SwiftUIView.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

// MARK: Public modifiers
struct Permissions: ViewModifier{
    @Binding var showModal:Bool

    func body(content: Content) -> some View {
        MainView(for: AnyView(content), show: $showModal)
    }
}
public extension View{
    
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
        Returns a new view, a modal that will overlay your existing view to show PermissionsSwiftUI related.
     
     */
    
    func JMPermissions(showModal:Binding<Bool>, for permissions:[PermissionModel]) -> some View{
        PermissionModel.PermissionModelStore.permissions = permissions
        return self.modifier(Permissions(showModal:showModal))
    }
}
// MARK: - Package modifiers
struct ButtonStatusColor:ViewModifier{
    var allowButtonStatus:AllowButtonStatus
    func body(content: Content) -> some View {
        switch allowButtonStatus{
        case .idle:
            return content
                .frame(width:70)
                .font(.system(size: 15))
                .foregroundColor(Color(.systemBlue))
                .padding(4)
                .padding(.horizontal,2)
                .background(
                    Capsule()
                        .fill(Color(.white))
                )
                .animation(.default)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

        case .allowed:
            return content
                .frame(width:70)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(4)
                .padding(.horizontal,2)
                .background(
                    Capsule()
                        .fill(Color(.systemBlue))
                )
                .animation(.default)
                .lineLimit(1)
                .minimumScaleFactor(0.5)


        case .denied:
            return content
                .frame(width:70)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(4)
                .padding(.horizontal,2)
                .background(
                    Capsule()
                        .fill(Color(.systemRed))
                )
                .animation(.default)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

        }
    }
}

extension View{
    func buttonStatusColor(for allowButtonStatus:AllowButtonStatus) -> some View{
        self.modifier(ButtonStatusColor(allowButtonStatus: allowButtonStatus))
    }
}
