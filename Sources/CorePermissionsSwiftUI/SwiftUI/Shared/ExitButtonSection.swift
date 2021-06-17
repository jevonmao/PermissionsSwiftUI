//
//  ExitButtonSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
struct ExitButtonSection: View {
    //Action is closing the alert or modal on tap
    var action: () -> Void
    var buttonSizeConstant: CGFloat {
        screenSize.width < 400 ? 40-(1000-screenSize.width)/80 : 40
    }
    @EnvironmentObject var schemaStore: PermissionSchemaStore
    var body: some View {
        Button(action: {
            #if !os(tvOS)
                let haptics = HapticsManager()
                if schemaStore.shouldStayInPresentation {
                    haptics.notificationImpact(.error)
                    
                }
            #endif
            action()
            
        }, label: {
            Circle()
                .fill(Color(.systemGray4))
                .frame(width: buttonSizeConstant, height: buttonSizeConstant)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.2)
                        .foregroundColor(Color(.systemGray))
                        .padding(4)
                )
        })
        .accessibility(identifier: "Exit button")
    }
}

