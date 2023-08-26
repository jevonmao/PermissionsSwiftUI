//
//  JMLocationInUsePermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/18/21.
//


import Foundation
import MapKit
import CorePermissionsSwiftUI

@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionManager {
    ///The `location` permission allows the device's positoin to be tracked
    static let location = JMLocationPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final class JMLocationPermissionManager: PermissionManager, CLLocationManagerDelegate {
    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationPermissionManager
    

    public override var permissionType: PermissionType {
        .location
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            return .authorized
        case .authorizedWhenInUse:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }

    var completionHandler: ((Bool, Error?) -> Void)?
    var locationManager = CLLocationManager()
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            
            //Completion handler called from this delegate function
            //Both authorizedAlways and authorizedWhenInUse will be acceptable
            completionHandler(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false, nil)
            
        }
    }
    //Used to request in use permission (1 of 2 types of iOS location permission)
    override public func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        self.completionHandler = completion
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
        default:
            completion(status == .authorizedWhenInUse || status == .authorizedAlways ? true : false, nil)
        }
    }

    deinit {
        locationManager.delegate = nil
    }
}
