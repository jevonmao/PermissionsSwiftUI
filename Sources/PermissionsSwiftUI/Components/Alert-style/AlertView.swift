//
//  AlertView.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

struct AlertView: View {
    var body: some View {
        ZStack{
            VStack{
                HeaderText(exitButtonAction: {}, isAlert: true)
                Spacer()
            }
            .padding(5)
        }
        .background(Blur(style: .systemThinMaterialDark))
        .frame(width: screenSize.width-60, height: screenSize.height/2)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
