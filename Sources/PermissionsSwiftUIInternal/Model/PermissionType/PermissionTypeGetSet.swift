//
//  PermissionModelGet.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
extension PermissionType: CaseIterable {
    public static var allCases: [PermissionType] {
        #if !os(tvOS)
        if #available(iOS 14, *) {
            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech,.tracking, .health]
        } else {
            return [.location,.locationAlways,.photo,microphone,.camera,.notification,.calendar,.bluetooth,.contacts,.motion,.reminders,.speech, .health]
        }
        #else
        if #available(tvOS 14, *) {
            return [.location, .photo, .notification, .bluetooth, .tracking]
        }
        else {
            return [.location, .photo, .notification, .bluetooth]
        }
        #endif
    }
    var rawValue: String {
        guard let label = Mirror(reflecting: self).children.first?.label else {
            return .init(describing: self)
        }
        return label
    }
}
