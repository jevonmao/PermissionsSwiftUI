//
//  HeaderText.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
struct HeaderView: View {
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore
    var exitButtonAction:() -> Void
    //HeaderText component have slightly different UI for alert and modal.
    var mainText: MainTexts
    var body: some View {
        let style = schemaStore.permissionViewStyle
        VStack{
            VStack{
                if style == .alert{
                        Text("PERMISSIONS REQUEST")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemGray2))
                            //Make frame width take up as much space as possible, to make space for left align text
                            .frame(maxWidth:.infinity, alignment: .leading)
                            //Negative padding make the bottom title "shift up" a little
                            .padding(.vertical, -5)
                            .accessibility(identifier: "Alert header")
                    }
                
                HStack {
                    Text(.init(mainText.headerText))
                        .font(.system(style == .alert ? .title : .largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                        .allowsTightening(true)
                        .layoutPriority(1)
                        .accessibility(identifier: "Main title")
                            
                            
                    Spacer()
                    ExitButtonSection(action: {
                        exitButtonAction()
                        guard let handler = store.configStore.onDisappearHandler else {return}
                        handler(schemaStore.successfulPermissions, schemaStore.erroneousPermissions)
                    })
                        //Layout priority does not do anything
                        .layoutPriority(-1)
                }
            }
            //Extra padding for modal view only. Alert pop up space not enough for the extra paddings
            .padding(.top, style == .alert ? 0 : 30)
            .padding(.horizontal, style == .alert ? 0 : 16)
            
            if style == .modal {
                Text(.init(mainText.headerDescription))
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
                    .textHorizontalAlign(.leading)
                    .accessibility(identifier: "Modal header description")
            }
  
        }
        

            
    }
}
