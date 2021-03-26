//
//  PermissionManagerProctocol.swift
//  
//
//  Created by Jevon Mao on 2/18/21.
//

import Foundation

/**
 The authorization status for any iOS system permission
 */
public enum AuthorizationStatus {
    ///The explicitly allowed or `authorized` permission state
    case authorized
    ///The explicitly denied permission state
    case denied
    ///The state in which the user has granted limited access permission (ex. photos)
    case limited
    ///The `notDetermined` permission state, and the only state where it is possible to ask permission
    case notDetermined
}

protocol PermissionManager {
    var permissionType: PermissionType? {get set}
    var authorizationStatus: AuthorizationStatus {get}
    
    init(permissionType: PermissionType?)
    init()
    
    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void)
   
}

extension PermissionManager {
    var permissionType: PermissionType? {
        get {nil}
        set{}
    }
    init(permissionType: PermissionType?=nil){self.init()}
}

