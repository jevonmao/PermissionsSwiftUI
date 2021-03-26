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
    
    ///An  array of permissions that configures the permissions to request
    public var permissions: [PermissionType] = []
    
    //MARK: Configuration store
    public var configStore = ConfigStore()
    
    //MARK: Permission components store
    public var permissionComponentsStore = PermissionComponentsStore()
}

