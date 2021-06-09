//
//  PermissionSection.swift
//
//
//  Created by Jevon Mao on 1/30/21.
//

import MapKit
import SwiftUI
import UserNotifications

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

enum AllowButtonStatus:CaseIterable {
    case idle
    case allowed
    case denied
}

struct PermissionSectionCell: View {
    @State var permission: PermissionType
    @State var allowButtonStatus: AllowButtonStatus = .idle
    @State var permissionManager: PermissionManager?
    @Binding var showing: Bool
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
        let currentPermission = schemaStore.permissionComponentsStore.getPermissionComponent(for: permission, modify: {_ in})
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
        guard let permissionManager = permissionManager else {
            return
        }
        permissionManager.requestPermission{authorized, error in
            var result: JMResult!
            if permission == .notification {
                getNotificationAuthorizationStatus{
                    result = JMResult(permissionType: permission,
                                          authorizationStatus: $0,
                                          error: error)
                    setStatus(authorized: authorized, result: result)
                }
            }
            else {
                result = JMResult(permissionType: permission,
                                  authorizationStatus: permissionManager.authorizationStatus,
                                      error: error)
                setStatus(authorized: authorized, result: result)
            }
            
        }
    }
    
    func setStatus(authorized: Bool, result: JMResult) {
        schemaStore.permissionComponentsStore.getPermissionComponent(for: permission){permissionComponent in
            permissionComponent.interacted = true
            if authorized {
                allowButtonStatus = .allowed
                permissionComponent.authorized = true
                (schemaStore.successfulPermissions?.append(result)) ?? (schemaStore.successfulPermissions = [result])
            }
            else {
                allowButtonStatus = .denied
                permissionComponent.authorized = false
                (schemaStore.erroneousPermissions?.append(result)) ?? (schemaStore.erroneousPermissions = [result])
            }
        }
        DispatchQueue.main.async {
            schemaStore.objectWillChange.send()
        }
        //Backward compatibility - autoDismissAlert, autoDismissModal, and autoDismiss are all acceptable ways to trigger condition
        if shouldAutoDismiss &&
            
            //Current view style is alert and autoDismissAlert is true
            ((schemaStore.permissionViewStyle == .alert &&
                store.autoDismissAlert) ||
                //Current view style is modal and autoDismissModal is true
                (schemaStore.permissionViewStyle == .modal &&
                    store.autoDismissModal)) ||
            store.configStore.autoDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                showing = false
                guard let handler = store.configStore.onDisappearHandler else {return}
                handler(schemaStore.successfulPermissions ?? nil, schemaStore.erroneousPermissions ?? nil)
            }
        }
    }
    func getNotificationAuthorizationStatus(completion: @escaping (AuthorizationStatus) -> ()) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus{
            case .authorized:
                completion(.authorized)
            case .denied:
                completion(.denied)
            case .notDetermined:
                completion(.notDetermined)
            case .provisional:
                completion(.limited)
            default:
                completion(.denied)
            }
        }
    }
}
