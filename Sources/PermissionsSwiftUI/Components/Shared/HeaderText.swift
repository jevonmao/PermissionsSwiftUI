//
//  HeaderText.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

struct HeaderText: View {
    var exitButtonAction:() -> Void
    var isAlert:Bool = false
    var mainText:PermissionStore.MainTexts{PermissionStore.shared.mainTexts}
    var body: some View {
        HStack {
            if #available(iOS 14.0, *) {
                Text(mainText.headerText)
                    .font(.system(isAlert ? .title2 : .largeTitle, design: .rounded))
                    .fontWeight(isAlert ? .semibold : .bold)
                    .lineLimit(1)

            } else {
                #warning("Fix Me - correctly adjust font point size.")
                Text(mainText.headerText)
                    .font(.system(size: isAlert ? 20 : 25, design: .rounded))
                    .fontWeight(isAlert ? .semibold : .bold)
                    .lineLimit(1)
            }
            Spacer()
            ExitButtonSection(action: { exitButtonAction() })
        }
        .padding(isAlert ? 5 : 0)
        .padding()
        .padding(.top, isAlert ? 0 : 20)
        
        Text(mainText.headerDescription)
            .font(.system(isAlert ? .caption : .body, design: .rounded))
            .fontWeight(isAlert ? .regular : .medium)
            .foregroundColor(Color(.systemGray))
            .padding()
            .lineLimit(3)
            
    }
}

