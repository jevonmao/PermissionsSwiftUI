//
//  File.swift
//  
//
//  Created by Jevon Mao on 4/6/21.
//

import SwiftUI

extension View {
    @usableFromInline func withEnvironmentObjects(store: PermissionStore, permissionStyle: PermissionViewStyle) -> some View {
        self
            .environmentObject(store)
            .environmentObject(PermissionSchemaStore(store: store,
                                                     permissionViewStyle: permissionStyle))
    }
}
