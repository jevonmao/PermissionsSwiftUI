//
//  ExitButtonSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ExitButtonSection: View {
    var action: () -> Void
    var buttonSizeConstant:CGFloat{
        screenSize.width < 400 ? 40-(1000-screenSize.width)/80 : 40
    }
    var body: some View {
        Button(action: action, label: {
            Circle()
                .fill(Color(.systemGray4))
                .frame(width:buttonSizeConstant, height: buttonSizeConstant)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.2)
                        .foregroundColor(Color(.systemGray))
                        .padding(4)
                )
        })
    }
}

//
//Circle()
//    .fill(Color(.systemGray4))
//    .frame(maxWidth:40, maxHeight: 40)
//    .overlay( Image(systemName: "xmark")
//                .font(.system(size: 18, weight: .bold, design: .rounded))
//                .foregroundColor(Color(.systemGray))
//                .minimumScaleFactor(0.1)
//                .padding(6)
//
//
//
//            )
