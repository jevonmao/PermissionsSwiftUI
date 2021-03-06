//
//  FilterPermissions.swift
//
//
//  Created by Jevon Mao on 2/19/21.
//

import Foundation

var store: PermissionStore {
    PermissionStore.shared
}
struct FilterPermissions {
    // Based on struct boolean property, dependent on memory
    static func filterForUnauthorized(for permissions: [PermissionType]) -> [PermissionType] {
        let filteredPermissions = permissions.filter { $0.currentPermission.authorized == false }
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
            if permission.getPermissionManager()?.authorizationStatus == .notDetermined {
                filteredPermissions.append(permission)
            }
        }
        return filteredPermissions
    }
}
