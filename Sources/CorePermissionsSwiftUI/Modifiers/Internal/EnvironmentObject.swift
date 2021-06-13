//
//  File.swift
//  
//
//  Created by Jevon Mao on 4/6/21.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
extension View {
    @usableFromInline func withEnvironmentObjects(store: PermissionStore, permissionStyle: PermissionViewStyle) -> some View {
        self
            .environmentObject(store)
            .environmentObject(PermissionSchemaStore(store: store,
                                                     permissionViewStyle: permissionStyle))
    }
}
