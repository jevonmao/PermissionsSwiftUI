//
//  MockPermissionType.swift
//  
//
//  Created by Jevon Mao on 2/8/21.
//

import Foundation

struct MockPermissionType:PermissionTypeProtocol{
    var permissions: [PermissionType]
    
    func requestPermission(isPermissionGranted: @escaping (Bool) -> Void) {
        
    }
    
    
}
