//
//  ModalView.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ModalView: View {
    @Binding var showModal:Bool
    var permissions:[PermissionModel]
    var body: some View {
        VStack {
            HStack {
                Text("Need Permissions")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                
                Spacer()
                ExitButtonSection(action:{showModal.toggle()})
            }
            .padding()
            .padding(.top,20)
            
            Text("In order for you use certain features of this app, you need to give permissions. See description for each permission")
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color(.systemGray))
                .padding()
            PermissionSection(permissions: permissions)
            Spacer()
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)

        
        
    }
}

