//
//  AlertMainView.swift.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

//The root level view for alert-style
struct AlertMainView<Body: View>: View, CustomizableView {
    @EnvironmentObject var store: PermissionStore
    private var showAlert: Binding<Bool>
    private var bodyView: Body
    var shouldShowPermission:Bool{
        if store.configStore.autoCheckAuth{
            if showAlert.wrappedValue && 
                !store.undeterminedPermissions.isEmpty {
                return true
            }
            else {
                return false
            }
        }
        if showAlert.wrappedValue{
            return true
        }
        else {
            return false
        }
    }
    
    init(for bodyView: Body, show showAlert: Binding<Bool>) {
        self.bodyView = bodyView
        self.showAlert = showAlert
    }
    var body: some View {
        ZStack{
            let insertTransition = AnyTransition.opacity.combined(with: .scale(scale: 1.1)).animation(Animation.default.speed(1.6))
            let removalTransiton = AnyTransition.opacity.combined(with: .scale(scale: 0.9)).animation(Animation.default.speed(1.8))
            bodyView
            if shouldShowPermission {
                Group{
                    Blur(style: .systemUltraThinMaterialDark)
                        .transition(AnyTransition.opacity.animation(Animation.default.speed(1.6)))
                    AlertView(showAlert:showAlert)
                        .onAppear(perform: store.configStore.onAppear)
                        .onDisappear(perform: store.configStore.onDisappear)
                }
                .transition(.asymmetric(insertion: insertTransition, removal: removalTransiton))
                .edgesIgnoringSafeArea(.all)
                .animation(.default)

            }
        }


    }
}

