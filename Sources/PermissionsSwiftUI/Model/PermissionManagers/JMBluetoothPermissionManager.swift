//
//  JMBluetoothPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import CoreBluetooth
import UIKit

final class JMBluetoothPermissionManager: NSObject, PermissionManager {
    
    private var completion: ((Bool, Error?) -> Void)?
    private var manager: CBCentralManager?
    var authorizationStatus: AuthorizationStatus{
        if #available(iOS 13.0, tvOS 13.0, *) {
            switch CBCentralManager().authorization{
            case .allowedAlways:
                return .authorized
            case .notDetermined:
                return .notDetermined
            default:
                return .denied
            }
        } else {
            switch CBPeripheralManager.authorizationStatus(){
            case .authorized:
                return .authorized
            case .notDetermined:
                return .notDetermined
            default:
                return .denied
            }
        }
    }
    override init(){} 

    func requestPermission(_ completion: @escaping (Bool, Error?) -> Void) {
        self.completion = completion
        self.manager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension JMBluetoothPermissionManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            switch central.authorization {
            case .notDetermined:
                break
            case .allowedAlways:
                self.completion?(true, nil)
            default:
                self.completion?(false, nil)
            }
        } else {
            switch CBPeripheralManager.authorizationStatus(){
            case .authorized:
                self.completion?(true, nil)
            case .notDetermined:
                break
            default:
                self.completion?(false, nil)
            }
        }
    }
}
