//
//  String.swift
//  
//
//  Created by Jevon Mao on 12/27/21.
//

import Foundation

extension String {
    // https://stackoverflow.com/questions/25081757/whats-nslocalizedstring-equivalent-in-swift
    /// Swifty wrapper for accessing NSLocalizedString with only key parameter
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .module, value: "", comment: "")
    }
}
