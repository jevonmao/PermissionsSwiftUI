//
//  JMPermissionsView.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct MainView: View {
    private var showModal: Binding<Bool>
    private var bodyView: AnyView
    init(for bodyView: AnyView, show showModal: Binding<Bool>) {
        self.bodyView = bodyView
        self.showModal = showModal
    }

    var body: some View {
        bodyView
            .sheet(isPresented: showModal, content: {
                ModalView(showModal: showModal)
            })
    }
}
