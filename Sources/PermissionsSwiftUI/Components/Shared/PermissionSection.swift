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
    @EnvironmentObject var store: PermissionStore
    var _permissions: [PermissionType]?
    var permissions:[PermissionType] {
        #warning("Fix this awkward computed property.")
        return store.permissions
    }
    var body: some View {
        VStack {
            ForEach(permissions.indices, id: \.self) {
                PermissionSectionCell(permission: permissions[$0], showModal: $showModal)
                
                if permissions.count > 1 {
                    Divider()
                }
            }
        }
        
        
    }
}

enum AllowButtonStatus:CaseIterable {
    case idle
    case allowed
    case denied
}

struct PermissionSectionCell: View {
    @State var permission: PermissionType
    @State var allowButtonStatus: AllowButtonStatus = .idle
    @State var permissionManager: PermissionManager?
    @Binding var showModal: Bool
    @EnvironmentObject var store: PermissionStore
    @EnvironmentObject var schemaStore: PermissionSchemaStore

    //Empty unauthorized array means all permissions have been interacted
    var shouldAutoDismiss: Bool {FilterPermissions.filterForUnauthorized(with: store.permissions, store: schemaStore).isEmpty}
    
    //Computed constants based on device size for dynamic UI
    var screenSizeConstant: CGFloat {
        //Weirdass formulas that simply work
        screenSize.width < 400 ? 40-(1000-screenSize.width)/80 : 40
    }
    var fontSizeConstant: CGFloat {
        screenSize.width < 400 ? 20-(1000-screenSize.width)/150 : 20
    }
    var smallFontSizeConstant: CGFloat {
        fontSizeConstant - fontSizeConstant/2.8
    }
    var vertPaddingConstant: CGFloat {
        if schemaStore.permissionViewStyle == .alert {
            return screenSize.width < 400 ? 0 : 10
        }
        else{
            return 15
        }
    }
    var horiPaddingConstant: CGFloat {
        if schemaStore.permissionViewStyle == .alert {
            return 0
        }
        else{
            return 15
        }
    }
    var body: some View {
        let currentPermission = schemaStore.componentsInternalStore.getPermissionComponent(for: permission)
        HStack {
            currentPermission.imageIcon
                .foregroundColor(store.configStore.allButtonColors.primaryColor)
                .font(.system(size: screenSizeConstant))
                .frame(width: screenSizeConstant)
                .padding(.horizontal, 5)
            VStack(alignment: .leading) {
                Text(currentPermission.title)
                    .font(.system(size: fontSizeConstant))
                    .bold()
                    .lineLimit(1)
                    .layoutPriority(1)
                Text(currentPermission.description)
                    .font(.system(size: smallFontSizeConstant))
                    .lineLimit(3)
                    .foregroundColor(Color(.systemGray2))
                    .minimumScaleFactor(0.5)
                
            }
            .padding(.horizontal, 3)
            
            Spacer()
            if schemaStore.permissionViewStyle == .alert {
                //Call requestPermission (enum function) to make request to Apple API
                //The handleButtonState function will be executed based on result of request
                AllowButtonSection(action: handlePermissionRequest, allowButtonStatus: $allowButtonStatus)
            }
            else{
                AllowButtonSection(action: handlePermissionRequest, allowButtonStatus: $allowButtonStatus)
                .animation(.default)
            }
            
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, vertPaddingConstant)
        .padding(.horizontal, horiPaddingConstant)
    }
    
    func handlePermissionRequest() {
        permissionManager = permission.getPermissionManager()?.init(permissionType: permission)
        permissionManager?.requestPermission{authorized, error in
            var currentPermission = schemaStore.componentsInternalStore.getPermissionComponent(for: permission)
            currentPermission.interacted = true
            if authorized {
                allowButtonStatus = .allowed
                currentPermission.authorized = true
            }
            else {
                allowButtonStatus = .denied
                currentPermission.authorized = false
            }
            schemaStore.componentsInternalStore.setPermissionComponent(currentPermission, for: permission)
            DispatchQueue.main.async {
                schemaStore.objectWillChange.send()
            }
            if shouldAutoDismiss && store.configStore.autoDismiss {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    showModal = false
                }
            }
        }
        
        
        
        
    }
}
