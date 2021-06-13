//
//  JMContactsPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
#if !os(tvOS)
import Contacts
import AddressBook

struct JMContactsPermissionManager:PermissionManager {
    internal init() { super.init() }
    typealias authorizationStatus = CNAuthorizationStatus
    typealias permissionManagerInstance = JMContactsPermissionManager
    
    public override var authorizationStatus: AuthorizationStatus {
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    func requestPermission(_ completion: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
            let store = CNContactStore()
            store.requestAccess(for: .contacts, completionHandler: { (authStatus, error) in
                DispatchQueue.main.async {
                    completion(authStatus, error)
                }
            })
    }
}
extension JMContactsPermissionManager {
    typealias JMPermissionAuthorizationHandlerCompletionBlock = (Bool, Error?) -> Void
}
#endif