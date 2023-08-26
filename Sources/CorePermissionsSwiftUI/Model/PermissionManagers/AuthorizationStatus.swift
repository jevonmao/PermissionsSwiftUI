//
//  AuthorizationStatus.swift
//
//
//  Created by Jevon Mao on 2/18/21.
//

import Foundation

/**
 The authorization status for any iOS system permission
 */
public enum AuthorizationStatus: String, Hashable, Equatable {
    ///The explicitly allowed or `authorized` permission state
    case authorized
    ///The explicitly denied permission state
    case denied
    ///The state in which the user has granted limited access permission (ex. photos)
    case limited
    ///The temporary allowed state that limits the app's access (ex. allow once)
    case temporary
    ///The `notDetermined` permission state, and the only state where it is possible to ask permission
    case notDetermined
}


