//
//  AlertMainView.swift.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

//The root level view for alert-style
@usableFromInline struct AlertMainView<Body: View>: View, CustomizableView {
    typealias ViewType = Body
    var showing: Binding<Bool>
    var bodyView: ViewType
    @usableFromInline var store: PermissionStore
    @usableFromInline var schemaStore: PermissionSchemaStore
    init(for bodyView: ViewType, showing: Binding<Bool>, store: PermissionStore) {
        self.showing = showing
        self.bodyView = bodyView
        self.store = store
        self.schemaStore = PermissionSchemaStore(configStore: store.configStore,
                                                 permissions: store.permissions,
                                                 permissionComponentsStore: store.permissionComponentsStore,
                                                 permissionViewStyle: .alert)
    }
    var shouldShowPermission:Bool{
        if store.configStore.autoCheckAuth{
            if showing.wrappedValue &&
                !schemaStore.undeterminedPermissions.isEmpty {
                return true
            }
            else {
                return false
            }
        }
        if showing.wrappedValue{
            return true
        }
        else {
            return false
        }
    }
    @usableFromInline var body: some View {
        ZStack{
            let insertTransition = AnyTransition.opacity.combined(with: .scale(scale: 1.1)).animation(Animation.default.speed(1.6))
            let removalTransiton = AnyTransition.opacity.combined(with: .scale(scale: 0.9)).animation(Animation.default.speed(1.8))
            bodyView
            if shouldShowPermission {
                Group{
                    Blur(style: .systemUltraThinMaterialDark)
                        .transition(AnyTransition.opacity.animation(Animation.default.speed(1.6)))
                    AlertView(showAlert: showing)
                        .onAppear(perform: store.configStore.onAppear)
                        .onDisappear(perform: store.configStore.onDisappear)
                }
                .transition(.asymmetric(insertion: insertTransition, removal: removalTransiton))
                .edgesIgnoringSafeArea(.all)
                .animation(.default)

            }
        }.withEnvironmentObjects(store: store, permissionStyle: .alert)
        
    }
    
}
