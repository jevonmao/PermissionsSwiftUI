//
//  JMPermissionsView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI
import Introspect

struct MainView: View {
    @State var isModalNotShown = true
    var showModal: Binding<Bool>
    var bodyView: AnyView
    var _permissionsToAsk: [PermissionType]?
    var permissionsToAsk: [PermissionType] {
        guard _permissionsToAsk == nil else {
            return _permissionsToAsk!
        }
        return store.undeterminedPermissions
    }
    var shouldShowPermission: Binding<Bool>{
        Binding(get: {
            if store.autoCheckModalAuth && isModalNotShown {
                return !permissionsToAsk.isEmpty
            }
            return true
        }, set: {_ in})
    }
    @ObservedObject var permissionStore = store
    
    init(for bodyView: AnyView,
         show showModal: Binding<Bool>,
         permissionsToAsk: [PermissionType]?=nil) {
        self.bodyView = bodyView
        self.showModal = showModal
        self._permissionsToAsk = permissionsToAsk
    }
    
    var body: some View {
        bodyView
            .sheet(isPresented: showModal.combine(with: shouldShowPermission), content: {
                ModalView(showModal: showModal)
                    .onAppear(perform: permissionStore.onAppear)
                    .onDisappear(perform:permissionStore.onDisappear)
                    .onAppear{isModalNotShown=false}
                    .onDisappear{showModal.wrappedValue = false; isModalNotShown=true}
                    .introspectViewController{
                        if store.restrictModalDismissal {
                            $0.isModalInPresentation = store.isModalDismissalRestricted
                        }
                    }
                
            })
           
        
    }
    //if DEBUG to ensure these functions are never used in production. They are for unit testing only.
    #if DEBUG
    static func testCallOnAppear(){
        guard let onAppear = store.onAppear else {return}
        onAppear()
    }
    static func testCallOnDisappear(){
        guard let onDisappear = store.onDisappear else {return}
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
