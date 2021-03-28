//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/19/21.
//

import SwiftUI

public protocol CustomizableView: View {
    var store: PermissionStore {get}
    func setAccentColor(to color: Color) -> AnyView
    func setAccentColor(toPrimary primaryColor: Color, toTertiary tertiaryColor: Color) -> AnyView
    func setPermissionComponent(for permission: PermissionType, image:AnyView, title: String?, description: String?) -> AnyView
    func setPermissionComponent(for permission: PermissionType, title: String) -> AnyView
    func setPermissionComponent(for permission: PermissionType, description: String) -> AnyView
    func setAllowButtonColor(to colors:AllButtonColors) -> AnyView
    func changeHeaderTo(_ text:String) -> AnyView
    func changeHeaderDescriptionTo(_ text:String) -> AnyView
    func changeBottomDescriptionTo(_ text:String) -> AnyView
}
