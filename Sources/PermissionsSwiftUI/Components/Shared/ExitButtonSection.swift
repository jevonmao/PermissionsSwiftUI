//
//  ExitButtonSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ExitButtonSection: View {
    //Action is closing the alert or modal on tap
    var action: () -> Void
    var buttonSizeConstant: CGFloat {
        screenSize.width < 400 ? 40-(1000-screenSize.width)/80 : 40
    }
    var body: some View {
        Button(action: action, label: {
            Circle()
                .fill(Color(.systemGray4))
                .frame(width: buttonSizeConstant, height: buttonSizeConstant)
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

