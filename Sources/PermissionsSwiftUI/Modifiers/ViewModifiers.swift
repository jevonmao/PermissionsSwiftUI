//
//  ViewModifier.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import SwiftUI

struct ButtonStatusColor: ViewModifier {
    var allowButtonStatus: AllowButtonStatus
    func body(content: Content) -> some View {
        switch self.allowButtonStatus {
        case .idle:
            return content
                .frame(width: 70)
                .font(.system(size: 15))
                .foregroundColor(Color(.systemBlue))
                .padding(.vertical,6)
                .padding(.horizontal, 6)
                .background(
                    Capsule()
                        .fill(Color(.white))
                )
                .lineLimit(1)
                .minimumScaleFactor(0.5)

        case .allowed:
            return content
                .frame(width: 70)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.vertical,6)
                .padding(.horizontal, 6)
                .background(
                    Capsule()
                        .fill(Color(.systemBlue))
                )
                .lineLimit(1)
                .minimumScaleFactor(0.5)

        case .denied:
            return content
                .frame(width: 70)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.vertical,6)
                .padding(.horizontal, 6)
                .background(
                    Capsule()
                        .fill(Color(.systemRed))
                )
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

extension View {
    func buttonStatusColor(for allowButtonStatus: AllowButtonStatus) -> some View {
        self.modifier(ButtonStatusColor(allowButtonStatus: allowButtonStatus))
    }
}
