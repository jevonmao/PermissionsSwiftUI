//
//  PermissionManager.swift
//  PermissionsSwiftUI-Example
//
//  Created by Jevon Mao on 8/26/23.
//

import Foundation

/**
 A Permission Manager object that contains properties and functions related to a specific permission. Will be subclassed by any permission type.

 - warning: `PermissionManager` shoud never be referenced directly and used. It serves as an abstract interface for PermissionsSwiftUI's many permission modules.
 */
open class PermissionManager: NSObject, Identifiable {
    ///Holds the permission UI component, containing UI elements like text and image
    open var permissionComponent: JMPermission {
        get {
            preconditionFailure("This property must be overridden.")
        }
    }
    ///The type of permission
    open var permissionType: PermissionType {
        preconditionFailure("This property must be overridden.")
    }

    ///The authorization status of the permission
    open var authorizationStatus: AuthorizationStatus  {
        get {
            preconditionFailure("This property must be overridden.")
        }
    }

#if PERMISSIONSWIFTUI_HEALTH

    ///Holds the health permission subcategories, in case of health permission type subclass
    open var healthPermissionCategories: Set<HKSampleType>?

    /**
     Creates a new `PermissionManager` for health permission.

     - parameters:
     - healthPermissionCategories: Subcategory permissions of health permission to request
     */
    public init(_ healthPermissionCategories: Set<HKSampleType>? = nil) {
        self.healthPermissionCategories = healthPermissionCategories
    }
#else
    ///Creates a new `PermissionManager` for any type of child implemented permission
    public override init() {}
#endif

    /**
     Requests authorization for the current implemented type of permission.

     - parameters:
     - completion: Returns back whether the permission authorization is granted, and any errors
     */
    open func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        preconditionFailure("This method must be overridden.")
    }
}
