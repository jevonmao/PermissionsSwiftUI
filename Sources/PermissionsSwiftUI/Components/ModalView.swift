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
                    Text("Need Permissions")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                    
                    Spacer()
                    ExitButtonSection(action: { showModal.toggle() })
                }
                .padding()
                .padding(.top, 20)
                
                Text("In order for you use certain features of this app, you need to give permissions. See description for each permission")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray))
                    .padding()
                    
                PermissionSection()
                Text("Permission are necessary for all the features and functions to work properly. Without location permission, you won't be able to use the maps feature. Without photo permission, you can't send images in chat.")
                    .font(.system(.callout, design: .rounded))
                    .foregroundColor(Color(.systemGray))
                    .padding(.horizontal)
                Spacer()
            }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}
