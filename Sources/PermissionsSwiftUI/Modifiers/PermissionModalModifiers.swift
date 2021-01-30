//
//  SwiftUIView.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct Permissions: ViewModifier{
    @Binding var showModal:Bool
    var permissions:[PermissionList]
    func body(content: Content) -> some View {
        JMPermissions(for: AnyView(content), show: $showModal, permissions: permissions)
    }
}

public extension View{
    func JMPermissions(showModal:Binding<Bool>, for permissions:[PermissionList]) -> some View{
        self.modifier(Permissions(showModal:showModal, permissions: permissions))
    }
}
