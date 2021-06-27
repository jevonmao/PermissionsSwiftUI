//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/19/21.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
extension View {
    @usableFromInline func typeErased() -> AnyView {
        AnyView(self)
    }
}
