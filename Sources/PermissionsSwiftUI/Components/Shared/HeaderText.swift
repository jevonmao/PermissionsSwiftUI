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
        VStack{
            VStack{
                if isAlert{
                    Text("PERMISSIONS REQUEST")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemGray2))
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.vertical, -3)
                }
                HStack {
                    if #available(iOS 14.0, *) {
                        Text(mainText.headerText)
                            .font(.system(isAlert ? .title : .largeTitle, design: .rounded))
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
            }
            .padding()
            .padding(.top, isAlert ? 0 : 20)
            
            if !isAlert{
                Text(mainText.headerDescription)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray))
                    .padding()
                    .lineLimit(3)
            }
  
        }

            
    }
}

