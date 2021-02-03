//
//  PermissionSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import MapKit
import SwiftUI
struct PermissionSection: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            let permissions = PermissionModel.PermissionModelStore.permissions
            ForEach(permissions, id: \.self) {
                PermissionSectionCell(permission: $0)
                if permissions.count > 1 {
                    Divider()
                }
            }
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding()
        .padding(.horizontal, 5)
    }
}

enum AllowButtonStatus {
    case idle
    case allowed
    case denied
}

struct PermissionSectionCell: View {
    var permission: PermissionModel
    @State var allowButtonStatus: AllowButtonStatus = .idle
    var body: some View {
        let currentPermission = self.permission.currentPermission
        HStack {
            currentPermission.imageIcon
                .foregroundColor(Color.blue)
                .font(.system(size: 40))
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text(currentPermission.title)
                    .font(.system(size: 20))
                    .bold()
                Text(currentPermission.description)
                    .font(.footnote)
                    .lineLimit(3)
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(.horizontal, 5)

            Spacer()
            AllowButtonSection(action: {
                permission.requestPermission { authed in
                    if authed {
                        allowButtonStatus = .allowed
                    }
                    else {
                        allowButtonStatus = .idle
                    }
                }
            }, allowButtonStatus: $allowButtonStatus)
        }
        .padding(15)
        .frame(maxHeight:.infinity)
    }
}
