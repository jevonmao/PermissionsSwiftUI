//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/25/21.
//

import Combine

class PermissionSchemaStore: ObservableObject {

    //MARK: Filtered permission arrays
    /**
     A global array of permissions that configures the permissions to request
     
     - Warning: `permissionsToAsk` property is deprecated, renamed to `undeterminedPermissions`
     */
    @available(iOS, deprecated: 13.0, obsoleted: 15.0, renamed: "undeterminedPermissions")
    ///An array of undetermined permissions filtered out from `permissions`
    var permissionsToAsk: [PermissionType] {
        return undeterminedPermissions
    }
    var undeterminedPermissions: [PermissionType] {
        FilterPermissions.filterForShouldAskPermission(for: permissions)
    }
    var interactedPermissions: [PermissionType] {
        //Filter for permissions that are not interacted
        permissions.filter{permissionComponentsStore.getPermissionComponent(for: $0).interacted}
    }
    var shouldStayInPresentation: Bool {
        if configStore.restrictDismissal {
            //Empty means all permissions interacted, so should no longer stay in presentation
            return interactedPermissions.isEmpty
        }
        return false
    }
    var configStore: ConfigStore
    var permissions: [PermissionType]
    var permissionComponentsStore: PermissionComponentsStore
    var permissionViewStyle: PermissionViewStyle
    
    init(configStore: ConfigStore, permissions: [PermissionType], permissionComponentsStore: PermissionComponentsStore, permissionViewStyle: PermissionViewStyle) {
        self.configStore = configStore
        self.permissions = permissions
        self.permissionComponentsStore = permissionComponentsStore
        self.permissionViewStyle = permissionViewStyle
    }
    
}

enum PermissionViewStyle {
    case alert, modal
}
