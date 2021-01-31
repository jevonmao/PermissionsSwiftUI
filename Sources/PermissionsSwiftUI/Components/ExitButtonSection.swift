//
//  ExitButtonSection.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ExitButtonSection: View {
    var action:()->Void
    var body: some View {
        Button(action: action, label: {
            Circle()
                .fill(Color.black.opacity(0.2))
                .frame(width:40, height: 40)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color(.systemGray))
                )
                
        })
    }
}
