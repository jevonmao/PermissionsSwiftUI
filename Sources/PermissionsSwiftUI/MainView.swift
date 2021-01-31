//
//  JMPermissionsView.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct MainView: View {
    private var showModal:Binding<Bool>
    private var bodyView:AnyView
    private var permissions:[PermissionModel]
    init(for bodyView:AnyView, show showModal:Binding<Bool>, permissions:[PermissionModel]){
        self.bodyView = bodyView
        self.showModal = showModal
        self.permissions = permissions
    }
    var body: some View {
        bodyView
            .sheet(isPresented: showModal, content: {
                ModalView(showModal: showModal, permissions: permissions)
                   
            })
           
    }
}

