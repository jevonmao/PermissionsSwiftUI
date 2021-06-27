//
//  PermissionModelGet.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
extension PermissionType {
    var rawValue: String {
        guard let label = Mirror(reflecting: self).children.first?.label else {
            return .init(describing: self)
        }
        return label
    }
}
