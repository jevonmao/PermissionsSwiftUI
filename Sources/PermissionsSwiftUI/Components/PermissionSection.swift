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
    @Binding var showModal:Bool
    var body: some View {
        VStack {
            let permissions = PermissionStore.shared.permissions
            ForEach(permissions.indices, id: \.self) {
                PermissionSectionCell(permission: permissions[$0], showModal: $showModal)
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
    @State var permission: PermissionType
    @State var allowButtonStatus: AllowButtonStatus = .idle
    @Binding var showModal:Bool
    var isLast:Bool{
        ///Filter and only get unauthorized permissions
        let permissions = PermissionStore.shared.permissions.filter{$0.currentPermission.authorized==false}
        if permissions.count == 0{
            return true
        }
        else{
            return false
        }
    }
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
                    var currentPermission = permission.currentPermission
                    if authed {
                        allowButtonStatus = .allowed
                        currentPermission.authorized = true
                    }
                    else {
                        allowButtonStatus = .idle
                        currentPermission.authorized = false
                    }
                    permission.currentPermission = currentPermission
                    if isLast{
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                            showModal = false
                        }
                    }
                   
                    
                }
            }, allowButtonStatus: $allowButtonStatus)
        }
        .padding(15)
        .frame(maxHeight:.infinity)
    }
}
