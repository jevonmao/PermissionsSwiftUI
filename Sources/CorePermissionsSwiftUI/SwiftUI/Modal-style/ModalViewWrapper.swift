//
//  JMPermissionsView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI
import Introspect

@available(iOS 13.0, tvOS 13.0, *)
@usableFromInline struct ModalViewWrapper<Body: View>: View, CustomizableView {
    //store contains static configurations and customizations
    @usableFromInline var store: PermissionStore
    //schemaStore contains dynamically computed properties, and internal methods/properties
    @usableFromInline var schemaStore: PermissionSchemaStore
    //Keep track of whether modal as already been shown for 1st time
    @State var isModalNotShown = true
    @usableFromInline var showing: Binding<Bool>
    @usableFromInline var bodyView: Body
    //Placeholder to make sure permissionsToAsk only get computed value once
    //Otherwise, the list of permissions will change while the modal is still open, which is not good
    var _permissionsToAsk: [PermissionManager]?
    var permissionsToAsk: [PermissionManager] {
        guard _permissionsToAsk == nil else {
            return _permissionsToAsk!
        }
        return schemaStore.undeterminedPermissions
    }
    var shouldShowPermission: Binding<Bool>{
        Binding(get: {
            //configStore.autoCheckAuth is added in newer version. autoCheckModalAuth is backward compatibility
            if (store.configStore.autoCheckAuth ||
                    (store.autoCheckModalAuth || store.autoCheckAlertAuth)) &&
                //Prevent modal from unwanted dismiss while still presented
                isModalNotShown {
                //underterminedPermissions.isEmpty => No askable permissions => should not show modal
                return !permissionsToAsk.isEmpty
            }
            //Always show the modal regardless of permission status
            return true
        }, set: {_ in})
    }
    @usableFromInline init(for bodyView: Body,
         showing: Binding<Bool>,
         store: PermissionStore,
         permissionsToAsk: [PermissionManager]?=nil) {
        self.bodyView = bodyView
        self.showing = showing
        self._permissionsToAsk = permissionsToAsk
        self.store = store
        self.schemaStore = PermissionSchemaStore(store: store,
                                                 permissionViewStyle: .modal)
    }
    
    @usableFromInline var body: some View {
        Group {
            bodyView
                .sheet(isPresented: showing.combine(with: shouldShowPermission), content: {
                    ModalView(showModal: showing)
                        //Possible nil, to account for backward compatibility
                        .onAppear(perform: store.onAppear ?? store.configStore.onAppear)
                        .onDisappear(perform: store.onDisappear ?? store.configStore.onDisappear)
                        //Writing duplicate onAppear and OnDisappear is actually less lines of code
                        .onAppear{isModalNotShown=false}
                        .onDisappear{showing.wrappedValue = false; isModalNotShown=true}
                })
        }
        .withEnvironmentObjects(store: store, permissionStyle: .modal)

           
        
    }
    //if DEBUG to ensure these functions are never used in production. They are for unit testing only.
    #if DEBUG
    func testCallOnAppear(){
        guard let onAppear = store.configStore.onAppear else {return}
        onAppear()
    }
    func testCallOnDisappear(){
        guard let onDisappear = store.configStore.onDisappear else {return}
        onDisappear() 
    }
    #endif
    
}
//Extension Binding wrapper for Binding booleans
@available(iOS 13.0, tvOS 13.0, *)
extension Binding where Value == Bool{
    func combine(with value2: Binding<Bool>) -> Binding<Bool>{
        //Combine two Binding Bool conditions with AND operator
        return self.wrappedValue && value2.wrappedValue ? .constant(true) : .constant(false)
    }
}
