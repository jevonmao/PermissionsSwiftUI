//
//  JMBluetoothPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import CoreBluetooth
import UIKit

//Contributors: please see JMLocationPermissionManager.swift for code comments
class JMBluetoothPermissionManager: NSObject {
    typealias JMBluetoothPermissionHandler = (Bool) -> Void?
    private var completion: JMBluetoothPermissionHandler?
    private var manager: CBCentralManager?
    static let shared = JMBluetoothPermissionManager()

    func requestPermission(completion: @escaping (Bool) -> Void?) {
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
