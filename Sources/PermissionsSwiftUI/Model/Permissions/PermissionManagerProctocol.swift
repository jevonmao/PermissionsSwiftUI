//
//  PermissionManagerProctocol.swift
//  
//
//  Created by Jevon Mao on 2/18/21.
//

import Foundation

enum AuthorizationStatus{
    case authorized, denied, limited, notDetermined
}
protocol PermissionManager {
    static var shared:PermissionManager{get}
    var authorizationStatus:AuthorizationStatus {get}
    func requestPermission(_ completion: @escaping (Bool) -> Void)
}
