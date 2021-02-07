//
//  JMLocationPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import MapKit

class JMLocationPermissionManager: NSObject, CLLocationManagerDelegate {
    static var shared = JMLocationPermissionManager()
    var locationManager: CLLocationManager
    var completionHandler: JMPermissionAuthorizationHandlerCompletionBlock?
    var locationPermissionType: LocationPermissionType?
    enum LocationPermissionType {
        case whenInUse
        case always
    }
    init(locationManager:CLLocationManager = CLLocationManager()){
        self.locationManager = locationManager
        super.init()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }

        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            if self.locationPermissionType == .always {
                completionHandler(status == .authorizedAlways ? true : false)
            }
            else {
                completionHandler(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false)
            }
        }
    }
    
    
    func requestAlwaysPermission(_ completionHandler: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        self.completionHandler = completionHandler
        self.locationPermissionType = .always
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
        default:
            completionHandler(status == .authorizedAlways ? true : false)
        }
    }

    func requestInUsePermission(_ completionHandler: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        self.completionHandler = completionHandler
        self.locationPermissionType = .whenInUse
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
        default:
            completionHandler(status == .authorizedWhenInUse || status == .authorizedAlways ? true : false)
        }
    }

//    var isAuthorized: Bool {
//        let status = CLLocationManager.authorizationStatus()
//        if status == .authorizedAlways {
//            return true
//        }
//        return false
//    }
    
    deinit {
        locationManager.delegate = nil
    }
}

extension JMLocationPermissionManager {
    typealias JMPermissionAuthorizationHandlerCompletionBlock = (Bool) -> Void
}
