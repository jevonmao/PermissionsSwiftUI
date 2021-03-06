//
//  HeaderText.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

struct HeaderView: View {
    var exitButtonAction:() -> Void
    //HeaderText component have slightly different UI for alert and modal.
    var isAlert:Bool = false
    var mainText:PermissionStore.MainTexts{store.mainTexts}
    var body: some View {
        VStack{
            VStack{
                    if isAlert{
                        Text("PERMISSIONS REQUEST")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemGray2))
                            //Make frame width take up as much space as possible, to make space for left align text
                            .frame(maxWidth:.infinity, alignment: .leading)
                            //Negative padding make the bottom title "shift up" a little
                            .padding(.vertical, -5)
                    }
                
                HStack {
                        Text(mainText.headerText)
                            .font(.system(isAlert ? .title : .largeTitle, design: .rounded))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)
                            .allowsTightening(true)
                            .layoutPriority(1)
                            
                    Spacer()
                    ExitButtonSection(action: { exitButtonAction() })
                        //Layout priority does not do anything
                        .layoutPriority(-1)
                }
            }
            //Extra padding for modal view only. Alert pop up space not enough for the extra paddings
            .padding(.top, isAlert ? 0 : 30)
            .padding(.horizontal, isAlert ? 0 : 16)
            
            if !isAlert{
                Text(mainText.headerDescription)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray))
                    .padding()
                    //Limit line number to 3 for optimal UI, will automatically scale
                    .lineLimit(3)
                    //Can override parent's frame limits to allow adaptable font sizes on different device
                    .fixedSize(horizontal: false, vertical: true)
                    //Allow scacling down to half the original size on smaller screens
                    .minimumScaleFactor(0.5)
            }
  
        }
        

            
    }
}
