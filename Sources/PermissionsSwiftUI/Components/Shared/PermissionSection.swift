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
    var isAlert:Bool
    var permissions:[PermissionType] {
        let store = PermissionStore.shared
        if isAlert{
            if store.autoCheckAlertAuth{
                return store.undeterminedPermissions
            }
            else {
                return store.permissions
            }
        }
        if store.autoCheckModalAuth{
            return store.undeterminedPermissions
        }
        else {
            return store.permissions
        }
    }
    var body: some View {
        VStack {
            ForEach(permissions.indices, id: \.self) {
                PermissionSectionCell(permission: permissions[$0], showModal: $showModal, isAlert: isAlert)
                
                if permissions.count > 1 {
                    Divider()
                }
            }
        }
//        .onAppear{
//            PermissionStore
//        }

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
    @Binding var showModal: Bool
    //Whether used for modal or alert style component
    var isAlert: Bool
    //Empty unauthorized array means all permissions have been interacted
    var shouldAutoDismiss: Bool{FilterPermissions.filterForUnauthorized(for: PermissionStore.shared.permissions).isEmpty}
    
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
        if isAlert {
            return screenSize.width < 400 ? 0 : 10
        }
        else{
            return 15
        }
    }
    var horiPaddingConstant: CGFloat {
        if isAlert {
            return 0
        }
        else{
            return 15
        }
    }
    var body: some View {
        let currentPermission = self.permission.currentPermission
        HStack {
            currentPermission.imageIcon
                .foregroundColor(PermissionStore.shared.allButtonColors.primaryColor)
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
            if isAlert {
                //Call requestPermission (enum function) to make request to Apple API
                //The handleButtonState function will be executed based on result of request
                AllowButtonSection(action: {
                    permission.requestPermission(isPermissionGranted: {handleButtonState(for: $0)})
                }, allowButtonStatus: $allowButtonStatus)
            }
            else{
                AllowButtonSection(action: {
                    permission.requestPermission(isPermissionGranted: {handleButtonState(for: $0)})
                }, allowButtonStatus: $allowButtonStatus)
                .animation(.default)
            }
      
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, vertPaddingConstant)
        .padding(.horizontal, horiPaddingConstant)
    }
    
    func handleButtonState(for authorized:Bool){
        var currentPermission = permission.currentPermission
        currentPermission.interacted = true
        if authorized {
            allowButtonStatus = .allowed
            currentPermission.authorized = true
        }
        else {
            allowButtonStatus = .denied
            currentPermission.authorized = false
        }
        permission.currentPermission = currentPermission
        if isAlert{
            if shouldAutoDismiss && PermissionStore.shared.autoDismissAlert {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    showModal = false
                }
            }
        }
        else{
            if shouldAutoDismiss && PermissionStore.shared.autoDismissModal {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    showModal = false
                }
            }
        }
       
    }
}
