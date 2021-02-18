//
//  JMContactsPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import Contacts
import AddressBook

struct JMContactsPermissionManager {
    static let shared = JMContactsPermissionManager()
    func requestPermission(completion: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
            let store = CNContactStore()
            store.requestAccess(for: .contacts, completionHandler: { (authStatus, error) in
                DispatchQueue.main.async {
                    completion(authStatus)
                }
            })
    }
}
extension JMContactsPermissionManager {
    typealias JMPermissionAuthorizationHandlerCompletionBlock = (Bool) -> Void
}
