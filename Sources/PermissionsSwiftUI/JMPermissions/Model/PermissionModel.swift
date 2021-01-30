//
//  PermissionModel.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import Foundation
import SwiftUI

public enum PermissionList{
    case location
    case photo
    case calendar
    
    var currentPermission:JMPermission{
        switch self{
        case .location:
            return JMPermission(imageIcon: Image(systemName: "location.fill.viewfinder"), title: "Location", description: "Allow to access your location")
        default:
            return JMPermission(imageIcon: Image(systemName: "location.fill.viewfinder"), title: "Location", description: "Allow to access your location")
        }
    }
}

struct JMPermission{
    var imageIcon:Image
    var title:String
    var description:String
}
