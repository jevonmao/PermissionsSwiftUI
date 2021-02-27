//
//  JMLocationPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import MapKit

class JMLocationPermissionAlwaysManager: NSObject, CLLocationManagerDelegate, PermissionManager {
    
    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationPermissionAlwaysManager
    
    static var shared: PermissionManager = JMLocationPermissionAlwaysManager()
    var authorizationStatus: AuthorizationStatus{
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
    
    var locationManager: LocationManager
    //Completion block for is authorized or not authorized
    var completionHandler: ((Bool) -> Void)?
    
    init(locationManager:LocationManager = CLLocationManager()){
        self.locationManager = locationManager
        super.init()
    }
    //CLLocationManagerDelegate method triggered when user approve or deny permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            completionHandler(status == .authorizedAlways ? true : false)
        }
    }
    
    func requestPermission(_ completionHandler: @escaping (Bool) -> Void) {
        self.completionHandler = completionHandler
        var status:CLAuthorizationStatus{ 
            locationManager.authorizationStatus()
        }
        
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

}
