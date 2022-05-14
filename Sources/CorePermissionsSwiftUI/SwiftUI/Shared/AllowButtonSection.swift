//
//  AllowButtonSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
struct AllowButtonSection: View {
    var action: () -> Void
    var useAltText: Bool

    @Binding var allowButtonStatus: AllowButtonStatus

    var buttonText: String {
        if allowButtonStatus == .allowed {
            return "button_allowed"
        }
        if allowButtonStatus == .idle {
            if useAltText {
                return "button_next"
            }
            return "button_allow"
        }

        return "button_denied"
    }

    var body: some View {
        Button(action: action, label: {
            Text(LocalizedStringKey(buttonText), bundle: .module)
                .fontWeight(.bold)
                .buttonStatusColor(for: allowButtonStatus)
        })
        .layoutPriority(-1)
        .accessibility(identifier: "Allow button")
    }
}
