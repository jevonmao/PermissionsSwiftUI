//
//  PermissionModelSet.swift
//
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

/**
 The closure parameter of successfully requested permissions
 
 This typealias's underlying type, `[PermissionType: JMResult]`, can be accessed like a dictionary for the `JMResult` for each permission type requested. The dictionary will contain only permission types that are passed in to show in PermissionsSwiftUI view. If there is no successful permissions, this dictionary will be empty.
 
 - seeAlso: errorPermissions
 */
public typealias successPermissions = [PermissionType: JMResult]
/**
 The closure parameter of erroneous requested permissions
 
 This typealias's underlying type, `[PermissionType: JMResult]`, can be accessed like a dictionary for the `JMResult` for each permission type requested. The dictionary will contain only permission types that are passed in to show in PermissionsSwiftUI view. If there is all permission succeed, this dictionary will be empty.
 
 - seeAlso: errorPermissions
 */
public typealias errorPermissions = [PermissionType: JMResult]

//MARK: - Storage
/**
 The data storage class that contains reference to all the custom configurations
 
 - SeeAlso: PermissionSchemaStore
 */
public class PermissionStore: ObservableObject {
    
    //MARK: Creating a new store
    /**
     Initalizes and returns a new instance of `PermissionStore`
     
     - Returns: A configuration and customizable data store
     
     The `PermissionStore` initliazer accepts no parameters, instead, set properties after intialization:
     ```
     let store = PermissionStore()
     store.mainTexts.headerText = "PermissionsSwiftUI is the best library"
     */
    public init(){}
    
    ///An  array of permissions that configures the permissions to request
    public var permissions: [PermissionType] = []
    
    //MARK: Configuration store
    ///Custom configurations that alters PermissionsSwiftUI view's behaviors
    public var configStore = ConfigStore()
    
    //MARK: Permission components store
    /**
     Customizable displayed component for each PermissionType (types of permission)
     */
    public var permissionComponentsStore = PermissionComponentsStore()
}

