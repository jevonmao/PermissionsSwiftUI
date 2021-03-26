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
public class PermissionSchemaStore: ObservableObject {

    //MARK: Filtered permission arrays
    /**
     Computed and filtered permissions with `undetermined` status
     
     - Warning: `permissionsToAsk` property is deprecated, renamed to `undeterminedPermissions`
     */
    
    @available(iOS, deprecated: 13.0, obsoleted: 15.0, renamed: "undeterminedPermissions")
    var permissionsToAsk: [PermissionType] {
        return undeterminedPermissions
    }
    var undeterminedPermissions: [PermissionType] {
        FilterPermissions.filterForShouldAskPermission(for: permissions)
    }
    var interactedPermissions: [PermissionType] {
        //Filter for permissions that are not interacted
        permissions.filter{componentsInternalStore.getPermissionComponent(for: $0).interacted}
    }
    //MARK: Controls dismiss restriction
    var shouldStayInPresentation: Bool {
        if configStore.restrictDismissal {
            //Empty means all permissions interacted, so should no longer stay in presentation
            return !(interactedPermissions.count == permissions.count)
        }
        return false
    }
    //MARK: Initialized configuration properties
    var configStore: ConfigStore
    @Published var permissions: [PermissionType]
    var permissionViewStyle: PermissionViewStyle
    var componentsInternalStore: ComponentsInternalStore
    init(configStore: ConfigStore, permissions: [PermissionType], permissionComponentsStore: PermissionComponentsStore, permissionViewStyle: PermissionViewStyle) {
        self.configStore = configStore
        self.permissions = permissions
        self.permissionViewStyle = permissionViewStyle
        self.componentsInternalStore = ComponentsInternalStore(permissionComponentsStore: permissionComponentsStore)
    }
    
}

@usableFromInline enum PermissionViewStyle {
    case alert, modal
}
