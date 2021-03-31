//
//  ModalView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore

    @Binding var showModal: Bool
    var mainText: MainTexts{store.configStore.mainTexts}

    var body: some View {
        ScrollView {
            VStack { 
                HeaderView(exitButtonAction: {showModal = schemaStore.shouldStayInPresentation})
                    
                PermissionSection(showing: $showModal)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    .frame(maxWidth:UIScreen.main.bounds.width-30)

                Text(mainText.bottomDescription)
                    .font(.system(.callout, design: .rounded))
                    .foregroundColor(Color(.systemGray))
                    .padding(.horizontal)
                    .textHorizontalAlign(.leading)

                Spacer()
            }
            .padding(.bottom,30)

        }
        .background(Color(.secondarySystemBackground))
        .edgesIgnoringSafeArea(.all)
        .introspectViewController{
            if store.configStore.restrictDismissal {
                $0.isModalInPresentation = true
            }
        }
    }
}
