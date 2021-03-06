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
public enum AuthorizationStatus{
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
    static var shared:PermissionManager{get}
    var authorizationStatus:AuthorizationStatus {get}
    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void)
}
 
