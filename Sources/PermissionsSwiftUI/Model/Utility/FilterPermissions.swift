//
//  FilterPermissions.swift
//
//
//  Created by Jevon Mao on 2/19/21.
//

import Foundation

struct FilterPermissions {
    // Based on struct boolean property, dependent on memory
    static func filterForUnauthorized(with permissions: [PermissionType], store: PermissionStore) -> [PermissionType] {
        let filteredPermissions = permissions.filter {
            store.permissionComponentsStore.getPermissionComponent(for: $0).authorized == false
        }
        return filteredPermissions
    }
    
//    static func filterForInteracted(for permissions: [PermissionType]) -> [PermissionType] {
//        var filteredPermissions = [PermissionType]()
//        for permission in permissions {
//            if permission.getPermissionManager()?.authorizationStatus ==
//        }
//    }
    // Based on system API query, independent from memory
    static func filterForShouldAskPermission(for permissions: [PermissionType]) -> [PermissionType] {
        var filteredPermissions = [PermissionType]()
        
        for permission in permissions {
            if permission.getPermissionManager()?.init(permissionType: permission).authorizationStatus == .notDetermined {
                filteredPermissions.append(permission)
            }
        }
        return filteredPermissions
    }
}
