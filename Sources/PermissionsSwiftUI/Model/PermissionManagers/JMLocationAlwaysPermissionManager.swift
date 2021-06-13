//
//  JMLocationPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import MapKit

#if !os(tvOS)
final class JMLocationAlwaysPermissionManager: NSObject, CLLocationManagerDelegate, PermissionManager {
    init(permissionType: PermissionType?) {}
    
    
    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationAlwaysPermissionManager
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
    
    var locationManager: LocationManager = CLLocationManager()
    //Completion block for is authorized or not authorized
    var completionHandler: ((Bool, Error?) -> Void)?
    override init(){}

    init(locationManager:LocationManager = CLLocationManager()){
        self.locationManager = locationManager
    }
    //CLLocationManagerDelegate method triggered when user approve or deny permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            completionHandler(status == .authorizedAlways ? true : false, nil)
        }
    }
    
    func requestPermission(_ completionHandler: @escaping (Bool, Error?) -> Void) {
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
            completionHandler(status == .authorizedAlways ? true : false, nil)
        }
    }

}
#endif
