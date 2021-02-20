//
//  JMBluetoothPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import CoreBluetooth
import UIKit

class JMBluetoothPermissionManager: NSObject, PermissionManager { 

    private var completion: ((Bool) -> Void)?
    private var manager: CBCentralManager?
    var authorizationStatus: AuthorizationStatus{
        switch CBCentralManager().authorization{
        case .allowedAlways:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    static let shared: PermissionManager = JMBluetoothPermissionManager()
    
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        self.completion = completion
        self.manager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension JMBluetoothPermissionManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.authorization {
        case .notDetermined:
            break
        case .allowedAlways:
            self.completion?(true)
        default:
            self.completion?(false)
        }
    }
}
