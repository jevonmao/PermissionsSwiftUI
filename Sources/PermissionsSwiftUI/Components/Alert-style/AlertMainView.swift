//
//  AlertMainView.swift.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

//The root level view for alert-style
struct AlertMainView: View {
    private var showAlert: Binding<Bool>
    private var bodyView: AnyView
    var shouldShowPermission:Bool{
        if store.autoCheckAlertAuth{
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
    
    init(for bodyView: AnyView, show showAlert: Binding<Bool>) {
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
                        .onAppear(perform: store.onAppear)
                        .onDisappear(perform: store.onDisappear)
                }
                .transition(.asymmetric(insertion: insertTransition, removal: removalTransiton))
                .edgesIgnoringSafeArea(.all)
                .animation(.default)

            }
        }


    }
}

