//
//  JMLocationInUsePermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/18/21.
//


import Foundation
import MapKit

class JMLocationPermissionManager: NSObject, CLLocationManagerDelegate, PermissionManager {
    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationPermissionManager
    
    static var shared: PermissionManager = JMLocationPermissionManager()
    var authorizationStatus: AuthorizationStatus{
        switch locationManager.authorizationStatus(){
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

    var completionHandler: ((Bool) -> Void)?
    var locationManager: LocationManager
    
    init(locationManager:LocationManager = CLLocationManager()){
        self.locationManager = locationManager
        super.init()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = locationManager.authorizationStatus()
            completionHandler(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false)
            
        }
    }
    //Used to request in use permission (1 of 2 types of iOS location permission)
    func requestPermission(_ completionHandler: @escaping (Bool) -> Void) {
        self.completionHandler = completionHandler
        let status = locationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
        default:
            completionHandler(status == .authorizedWhenInUse || status == .authorizedAlways ? true : false)
        }
    }

    deinit {
        locationManager.delegate = nil
    }
}
