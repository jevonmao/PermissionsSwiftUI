//
//  PermissionSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import MapKit
import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
struct PermissionSection: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showing:Bool
    @EnvironmentObject var store: PermissionStore
    var _permissions: [PermissionType]?
    var permissions:[PermissionType] {
        return store.permissions
    }
    var body: some View {
        VStack {
            ForEach(permissions.indices, id: \.self) {
                PermissionSectionCell(permission: permissions[$0], showing: $showing)
                
                if permissions.count > 1 {
                    Divider()
                }
            }
        }
        
        
    }
}

