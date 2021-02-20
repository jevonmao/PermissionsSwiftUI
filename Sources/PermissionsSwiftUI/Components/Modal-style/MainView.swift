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
    var shouldShowPermission:Binding<Bool> = Binding(get: {
        let store = PermissionStore.shared
        if store.autoCheckModalAuth{
            return !PermissionStore.shared.permissionsToAsk.isEmpty
        }
        return true
    }, set: {_ in})
    init(for bodyView: AnyView, show showModal: Binding<Bool>) {
        self.bodyView = bodyView
        self.showModal = showModal
    }

    var body: some View {
            bodyView
                .sheet(isPresented: showModal.combine(with: shouldShowPermission), content: {
                    ModalView(showModal: showModal)
                        .onAppear(perform: PermissionStore.shared.onAppear)
                        .onDisappear(perform:PermissionStore.shared.onDisappear)
                        .onDisappear{showModal.wrappedValue = false}

                })
     
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
//Extension Binding wrapper for Binding booleans
extension Binding where Value == Bool{
    func combine(with value2: Binding<Bool>) -> Binding<Bool>{
        //Combine two Binding Bool conditions with AND operator
        return self.wrappedValue && value2.wrappedValue ? .constant(true) : .constant(false)
    }
}
