//
//  AllowButtonSection.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct AllowButtonSection: View {
    var action:()->Void
    @Binding var allowButtonStatus:AllowButtonStatus
    var body: some View {
        Button(action: action, label: {
            Text(allowButtonStatus == .allowed ? "Allowed" : "Allow")
                .fontWeight(.bold)
                .buttonStatusColor(for: allowButtonStatus)
        })
     
    }
}

