//
//  JMLocationPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import MapKit
import CorePermissionsSwiftUI

#if !os(tvOS)
@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    static let locationAlways = JMLocationAlwaysPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMLocationAlwaysPermissionManager: PermissionType.PermissionManager, CLLocationManagerDelegate {
    internal init() { super.init() }

    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationAlwaysPermissionManager
    public override var permissionType: PermissionType {
        .locationAlways
    }
    public override var authorizationStatus: AuthorizationStatus {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            //In use only permission will be counted as denied
            return .denied
        }
        
    }
    
    var locationManager = CLLocationManager()
    //Completion block for is authorized or not authorized
    var completionHandler: ((Bool, Error?) -> Void)?
    
    //CLLocationManagerDelegate method triggered when user approve or deny permission
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            completionHandler(status == .authorizedAlways ? true : false, nil)
        }
    }
    
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        self.completionHandler = completion
        var status:CLAuthorizationStatus{ 
            CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
        default:
            if let completionHandler = completionHandler {
                completionHandler(status == .authorizedAlways ? true : false, nil)
            }
        }
    }
    
}
#endif
