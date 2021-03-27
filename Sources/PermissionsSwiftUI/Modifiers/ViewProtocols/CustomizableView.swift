//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/19/21.
//

import SwiftUI

/**
 Creates any style of PermissionsSwiftUI view with custom configurations
 
 The `JMModal` and `JMAlert` modifier are higher-level containers for `AlertMainView` and `ModalMainView`. Both of those conform to the `CustomizableView` protocol, which allows it to be configured with PermissionSwiftUI's customization modifiers.
 */
public protocol CustomizableView: View {
    //MARK: Environment data storage
    ///A global data storage object that is implemented by views
    var store: PermissionStore {get}
    ///A schema storage object that is implemented by views
    var schemaStore: PermissionSchemaStore {get}
}
