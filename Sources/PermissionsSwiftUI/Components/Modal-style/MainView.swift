//
//  JMPermissionsView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct MainView: View {
    private var showModal: Binding<Bool>
    private var bodyView: AnyView
    var shouldShowPermission:Bool{
        PermissionStore.shared.permissionsToAsk.isEmpty ? false : true
    }
    init(for bodyView: AnyView, show showModal: Binding<Bool>) {
        self.bodyView = bodyView
        self.showModal = showModal
    }

    var body: some View {
        if shouldShowPermission{
            bodyView
                .sheet(isPresented: showModal, content: {
                    ModalView(showModal: showModal)
                        .onAppear(perform: PermissionStore.shared.onAppear)
                        .onDisappear(perform:PermissionStore.shared.onDisappear)

                })
        }
    }
    //if DEBUG to ensure these functions are never used in production. They are for unit testing only.
    #if DEBUG
    static func testCallOnAppear(){
        guard let onAppear = PermissionStore.shared.onAppear else {return}
        onAppear()
    }
    static func testCallOnDisappear(){
        guard let onDisappear = PermissionStore.shared.onDisappear else {return}
        onDisappear()
    }
    #endif

}
