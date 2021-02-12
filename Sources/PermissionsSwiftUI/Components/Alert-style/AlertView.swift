//
//  AlertView.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

struct AlertView: View {
    @Binding var showAlert:Bool
    var mainText:PermissionStore.MainTexts{PermissionStore.shared.mainTexts}
    var body: some View {
        ZStack{

            VStack{
                HeaderText(exitButtonAction: {showAlert = false}, isAlert: true)
                PermissionSection(showModal: $showAlert, isAlert:true)
                
                if PermissionStore.shared.permissions.count < 2{
                    Divider()
                }
                Text(mainText.bottomDescription)
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                    .padding()
                    .lineLimit(3)
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
            .padding(5)
            .background(Color(.systemBackground).opacity(0.8))
            .frame(width: screenSize.width > 375 ? 375 : screenSize.width-60)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }

        
    }
}
