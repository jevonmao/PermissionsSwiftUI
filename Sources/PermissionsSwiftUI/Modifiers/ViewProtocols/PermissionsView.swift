//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/19/21.
//

import SwiftUI

protocol JMPermissionsView {
    associatedtype Body: View
    init(for bodyView: Body, show showAlert: Binding<Bool>)
}
