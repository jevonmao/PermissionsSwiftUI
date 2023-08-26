//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/25/21.
//

import Combine

/**
 The schema storage class that coordinates PermissionsSwiftUI's internal functions
 */

@available(iOS 13.0, tvOS 13.0, *)
public class PermissionSchemaStore: ObservableObject {

    //MARK: Filtered permission arrays
    var undeterminedPermissions: [PermissionManager] {
        FilterPermissions.filterForShouldAskPermission(for: permissions)
    }
    var interactedPermissions: [PermissionManager] {
        //Filter for permissions that are not interacted
        permissions.filter {
            permissionComponentsStore.getPermissionComponent(for: $0.permissionType).interacted
        }
    }
    var successfulPermissions: [JMResult]?
    var erroneousPermissions: [JMResult]?
    
    //MARK: Controls dismiss restriction
    var shouldStayInPresentation: Bool {
        if configStore.restrictDismissal ||
            ((permissionViewStyle == .modal && store.restrictModalDismissal) ||
                (permissionViewStyle == .alert && store.restrictAlertDismissal)) {
            // number of interacted permissions equal to number
            // of all permissions means means everything has been
            // interacted with, thus if so, shouldStayInPresentation
            // will be false and dismissal is allowed
            return !(interactedPermissions.count == permissions.count)
        }
        return false
    }
    //MARK: Initialized configuration properties
    var configStore: ConfigStore
    var store: PermissionStore
    @Published var permissions: [PermissionManager]
    var permissionViewStyle: PermissionViewStyle
    @usableFromInline var permissionComponentsStore: PermissionComponentsStore
    init(store: PermissionStore, permissionViewStyle: PermissionViewStyle) {
        self.configStore = store.configStore
        self.permissions = store.permissions
        self.permissionComponentsStore = store.permissionComponentsStore
        self.store = store
        self.permissionViewStyle = permissionViewStyle
    }

}

@usableFromInline enum PermissionViewStyle {
    case alert, modal
}
