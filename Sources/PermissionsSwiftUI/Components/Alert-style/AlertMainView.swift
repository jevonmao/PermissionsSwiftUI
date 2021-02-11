//
//  AlertMainView.swift.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

struct AlertMainView: View {
    private var showModal: Binding<Bool>
    private var bodyView: AnyView
    init(for bodyView: AnyView, show showModal: Binding<Bool>) {
        self.bodyView = bodyView
        self.showModal = showModal
    }
    var body: some View {
        ZStack{
            bodyView
            AlertView()
        }
    }
}

