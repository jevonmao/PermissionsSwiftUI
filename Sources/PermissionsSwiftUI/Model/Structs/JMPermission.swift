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
 
 `JMPermission` conforms to `Equatable` and `Hashable`. The PermissionsSwiftUI view interface will be rendered based on information from `JMPermission` structure
 */
@available(iOS 13.0, tvOS 13.0, *)
public struct JMPermission: Equatable{

    
    /**
     Initializes a new instance of `JMPermission` that encapsulates properties of a single permission
          
     - Parameters:
        - imageIcon: Defines the image icon displayed for the permission component
        - title: Defines the title text of the permission component
        - description: Defines the description text of the permission component
        - authorized: Tracks the authorization status of ther permission
     */
    public init(imageIcon: AnyView, title: String, description: String) {
        self.imageIcon = imageIcon
        self.title = title
        self.description = description
    }
    @usableFromInline internal init(imageIcon: AnyView, title: String, description: String, authorized: Bool) {
        self.imageIcon = imageIcon
        self.title = title
        self.description = description
        self.authorized = authorized
    }
    /**
     Compares two instances of equatable `JMPermission`, based on the title text, description text, and authorized status
     
     `imageIcon` will be ignored by the comparison operature, because it is a type erased `AnyView` and cannot be compared
          
     - Parameters:
        - imageIcon: Defines the image icon displayed for the permission component
        - title: Defines the title text of the permission component
        - description: Defines the description text of the permission component
        - authorized: Tracks the authorization status of ther permission
     */
    public static func == (lhs: JMPermission, rhs: JMPermission) -> Bool {
        if lhs.title == rhs.title && lhs.description == rhs.description && lhs.authorized == rhs.authorized{
            return true
        }
        else{
            return false
        }
    }
    ///The image icon displayed
    public var imageIcon: AnyView
    ///The permission name displayed
    public var title: String
    ///The permission description displayed
    public var description: String
    @usableFromInline internal var authorized:Bool = false
    internal var interacted:Bool = false
}

