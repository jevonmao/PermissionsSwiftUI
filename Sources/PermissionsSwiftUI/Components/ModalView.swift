//
//  ModalView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ModalView: View {
    @Binding var showModal: Bool
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(PermissionModel.PermissionModelStore.headerText)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                    Spacer()
                    ExitButtonSection(action: { showModal.toggle() })
                }
                .padding()
                .padding(.top, 20)
                
                Text(PermissionModel.PermissionModelStore.headerDescription)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray))
                    .padding()
                    
                PermissionSection(showModal:$showModal)

                Text(PermissionModel.PermissionModelStore.bottomDescription)
                    .font(.system(.callout, design: .rounded))
                    .foregroundColor(Color(.systemGray))
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.bottom,30)

        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}
