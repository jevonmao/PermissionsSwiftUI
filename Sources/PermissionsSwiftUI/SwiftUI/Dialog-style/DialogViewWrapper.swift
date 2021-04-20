//
//  AlertMainView.swift.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

//The root level view for alert-style
@available(iOS 13.0, *)
@available(tvOS, unavailable, message: "Dialog style permission view is unavailable for tvOS, use modal style instead.")
@usableFromInline struct DialogViewWrapper<Body: View>: View, CustomizableView {
    @usableFromInline typealias ViewType = Body
    @usableFromInline var showing: Binding<Bool>
    @usableFromInline var bodyView: ViewType
    @usableFromInline var store: PermissionStore
    @usableFromInline var schemaStore: PermissionSchemaStore
    init(for bodyView: ViewType, showing: Binding<Bool>, store: PermissionStore) {
        self.showing = showing
        self.bodyView = bodyView
        self.store = store
        self.schemaStore = PermissionSchemaStore(store: store,
                                                 permissionViewStyle: .alert)
    }
    var shouldShowPermission:Bool{
        //Handles case where configuration for autoCheckAuth is true
        if store.configStore.autoCheckAuth || store.autoCheckAlertAuth {
            if showing.wrappedValue &&
                //schemaStore underterminedPermissions (askable permissions) must not be empty
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
                    #if !os(tvOS)
                    Blur(style: .systemUltraThinMaterialDark)
                        .transition(AnyTransition.opacity.animation(Animation.default.speed(1.6)))
                    #else
                    Blur(style: .extraDark)
                        .transition(AnyTransition.opacity.animation(Animation.default.speed(1.6)))
                    #endif
                    DialogView(showAlert: showing)
                        .onAppear(perform: store.onAppear ?? store.configStore.onAppear)
                        .onDisappear(perform: store.onDisappear ?? store.configStore.onDisappear)
                     
                }
                .transition(.asymmetric(insertion: insertTransition, removal: removalTransiton))
                .edgesIgnoringSafeArea(.all)
                .animation(.default)

            }
        }.withEnvironmentObjects(store: store, permissionStyle: .alert)
        
    }
    
}
