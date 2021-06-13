//
//  JMLocationInUsePermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/18/21.
//


import Foundation
import MapKit

final class JMLocationPermissionManager: NSObject, CLLocationManagerDelegate, PermissionManager {
    typealias authorizationStatus = CLAuthorizationStatus
    typealias permissionManagerInstance = JMLocationPermissionManager
    internal init() { super.init() }

    public override var authorizationStatus: AuthorizationStatus {
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

    var completionHandler: ((Bool, Error?) -> Void)?
    var locationManager: LocationManager = CLLocationManager()
    override init(){}
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
            
            //Completion handler called from this delegate function
            //Both authorizedAlways and authorizedWhenInUse will be acceptable
            completionHandler(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false, nil)
            
        }
    }
    //Used to request in use permission (1 of 2 types of iOS location permission)
    func requestPermission(_ completionHandler: @escaping (Bool, Error?) -> Void) {
        self.completionHandler = completionHandler
        let status = locationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
        default:
            completionHandler(status == .authorizedWhenInUse || status == .authorizedAlways ? true : false, nil)
        }
    }

    deinit {
        locationManager.delegate = nil
    }
}
