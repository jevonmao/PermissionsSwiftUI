//
//  PermissionModelSet.swift
//
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

public typealias successPermissions = [PermissionType: JMResult]
public typealias errorPermissions = [PermissionType: JMResult]

//MARK: - Storage
/**
 The data storage class that contains reference to all of PermissionSwiftUI's data
 */
public class PermissionStore: ObservableObject {
    
    //MARK: Creating a new store
    /**
     Initalizes and returns a new instance of `PermissionStore`
     
     The `PermissionStore` initliazer accepts no parameters, instead, set properties after intialization:
     ```
     let store = PermissionStore()
     store.mainTexts.headerText = "PermissionsSwiftUI is the best library"
     */
    public init(){}
    //a private singleton instance that allows read & write, but for this file's methods only
    fileprivate static var mutableShared = PermissionStore()
    //Read only singleton exposed to other parts of program
    static var shared: PermissionStore {
        get{
            mutableShared
        }
    }
    
    ///An  array of permissions that configures the permissions to request
    @Published public var permissions: [PermissionType] = []
    
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
    
    //MARK: Configuration store
    public var configStore = ConfigStore()
    
    //MARK: Permission components store
    public var permissionComponentsStore = PermissionComponentsStore()
}

