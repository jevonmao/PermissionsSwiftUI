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
    
    lazy var locationManager: CLLocationManager =  {
        return CLLocationManager()
    }()
    
    var completionHandler: JMPermissionAuthorizationHandlerCompletionBlock?
    var locationPermissionType:LocationPermissionType?
    enum LocationPermissionType{
        case whenInUse
        case always
    }
    override init() {
        super.init()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            if locationPermissionType == .always{
                completionHandler(status == .authorizedAlways ? true : false)
            }
            else{
                completionHandler(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false)
            }
        }
    }
    
    private var whenInUseNotRealChangeStatus: Bool = false
    
    func requestAlwaysPermission(_ completionHandler: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        self.completionHandler = completionHandler
        locationPermissionType = .always
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            self.whenInUseNotRealChangeStatus = true
        default:
            completionHandler(status == .authorizedAlways ? true : false)
        }
    }
    func requestInUsePermission(_ completionHandler: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        self.completionHandler = completionHandler
        locationPermissionType = .whenInUse
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
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
