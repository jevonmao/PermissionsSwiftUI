//
//  JMPermissionsView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct MainView: View {
    var showModal: Binding<Bool>
    var bodyView: AnyView
    var permissionsToAsk: [PermissionType]
    var shouldShowPermission:Binding<Bool>{
        Binding(get: {
            let store = PermissionStore.shared
            if store.autoCheckModalAuth{
                return !permissionsToAsk.isEmpty
            }
            return true
        }, set: {_ in})
    }
    init(for bodyView: AnyView,
         show showModal: Binding<Bool>,
         permissionsToAsk: [PermissionType]=PermissionStore.shared.permissionsToAsk) {
        self.bodyView = bodyView
        self.showModal = showModal
        self.permissionsToAsk = permissionsToAsk
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
