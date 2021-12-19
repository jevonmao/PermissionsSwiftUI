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
    @Binding var allowButtonStatus: AllowButtonStatus
    var body: some View {
        Button(action: action, label: {
            Text(allowButtonStatus == .allowed ?
                 "ALLOWED" : allowButtonStatus == .idle ?
                 "ALLOW" : "DENIED", bundle: .module)
                .fontWeight(.bold)
                .buttonStatusColor(for: allowButtonStatus)
        })
        .layoutPriority(-1)
        .accessibility(identifier: "Allow button")
    }
}
