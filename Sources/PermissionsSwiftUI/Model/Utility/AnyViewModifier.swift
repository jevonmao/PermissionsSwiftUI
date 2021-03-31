//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/19/21.
//

import SwiftUI

extension View {
    @usableFromInline func typeErased() -> AnyView {
        AnyView(self)
    }
}
