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
    var paddingSize:CGFloat{
        screenSize.width < 400 ? 20-(1000-screenSize.width)/120 : 20
    }
    var body: some View {
            VStack{
                HeaderText(exitButtonAction: {showAlert = false}, isAlert: true)
                    .padding(.bottom, paddingSize/1.5)
                PermissionSection(showModal: $showAlert, isAlert:true)
                
                if PermissionStore.shared.permissions.count < 2{
                    Divider()
                }
                Text(mainText.bottomDescription)
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                    .lineLimit(3)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .minimumScaleFactor(0.5)
            }
            .padding(paddingSize)
            .alertViewFrame()

        

        
    }
}

