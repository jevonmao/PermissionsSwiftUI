//
//  JMLocationPermissionManager.swift
//
//
//  Created by Jevon Mao on 1/31/21.
//

import Foundation
import MapKit

class JMLocationPermissionManager: NSObject, CLLocationManagerDelegate {
    //Singleton instance exposed to other structs and classes in module
    static var shared = JMLocationPermissionManager()
    //The master class for location related from Apple MapKit
    var locationManager: LocationManager
    //Completion handler passed in
    var completionHandler: JMPermissionAuthorizationHandlerCompletionBlock?
    //For selecting between when in use and location always permission
    var locationPermissionType: LocationPermissionType?
    enum LocationPermissionType {
        case whenInUse
        case always
    }
    //Dependency injection - can be passed in a mock object during testing
    init(locationManager:LocationManager = CLLocationManager()){
        self.locationManager = locationManager
        super.init()
    }
    //CLLocationManagerDelegate method that is triggered when uesr approve or deny permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        
        if let completionHandler = completionHandler {
            let status = CLLocationManager.authorizationStatus()
            //Always type permission will only evaluate to "true" if status is "authorizedAlways"
            if self.locationPermissionType == .always {
                //completionHandler will be called here
                completionHandler(status == .authorizedAlways ? true : false)
            }
            //When in use type is less strict, will evaluate to "true" if status is either "authorizedAlways" or "authorizedWhenInUse"
            else {
                completionHandler(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false)
            }
        }
    }
    
    //Used to request always use permission. Very similar to method below
    func requestAlwaysPermission(_ completionHandler: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        //Make a copy reference in class scope of the completionHandler passed in
        self.completionHandler = completionHandler
        self.locationPermissionType = .always
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
    //Used to request in use permission (1 of 2 types of iOS location permission)
    func requestInUsePermission(_ completionHandler: @escaping JMPermissionAuthorizationHandlerCompletionBlock) {
        self.completionHandler = completionHandler
        self.locationPermissionType = .whenInUse
        //Get the current permission status
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        //case notDetermined means status is in default mode. Permission can be asked in this status.
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
        //all other cases (denied, restricted.etc)
        default:
            completionHandler(status == .authorizedWhenInUse || status == .authorizedAlways ? true : false)
        }
    }

    deinit {
        locationManager.delegate = nil
    }
}
extension JMLocationPermissionManager {
    //Type alias for completion handler returning Bool for if permission is granted or no
    typealias JMPermissionAuthorizationHandlerCompletionBlock = (Bool) -> Void
}
