//
//  JMPermission.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

/**
 A data model that defines a JPPermission component and its data
 
 `JMPermission` conforms to `Equatable` and `Hashable`. Is used for abstractly store data for each permission.
 */

public struct JMPermission:Equatable{

    
    /**
     Initializes a new instance of JMPermission
     
     - Parameters:
        - imageIcon: Defines the image icon displayed for the permission component
        - title: Defines the title text of the permission component
        - description: Defines the description text of the permission component
        - authorized: Tracks the authorization status of ther permission
     - Attention:
        The `JMPermission` structure is made public only for obervation purposes. Users of PermissionsSwiftUI should not be calling `JMPermission` constructor directly.
     */
    public init(imageIcon: AnyView, title: String, description: String, authorized: Bool) {
        self.imageIcon = imageIcon
        self.title = title
        self.description = description
        self.authorized = authorized
    }
    
    public static func == (lhs: JMPermission, rhs: JMPermission) -> Bool {
        if lhs.title == rhs.title && lhs.description == rhs.description && lhs.authorized == rhs.authorized{
            return true
        }
        else{
            return false
        }
    }

    
    var imageIcon: AnyView
    var title: String
    var description: String
    var authorized:Bool
    
}
