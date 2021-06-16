//
//  MockLocationManager.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
#if PERMISSIONSWIFTUI_LOCATION
import MapKit

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? {get set}
    func authorizationStatus() -> CLAuthorizationStatus
    func requestWhenInUseAuthorization()
    #if !os(tvOS)
    func requestAlwaysAuthorization()
    #endif
}


extension CLLocationManager: LocationManager{
    func authorizationStatus() -> CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }
    
    
}
struct MockCLLocationManager:LocationManager{
    weak var delegate: CLLocationManagerDelegate?
    
    private static var status:CLAuthorizationStatus = .notDetermined
    var whenInUseRequestOverride: CLAuthorizationStatus = .authorizedWhenInUse
    var alwaysUseRequestOverride: CLAuthorizationStatus = .authorizedAlways

    func authorizationStatus() -> CLAuthorizationStatus {
        MockCLLocationManager.status
    }
    
    func requestWhenInUseAuthorization() {
        MockCLLocationManager.status = whenInUseRequestOverride
    }
    
    func requestAlwaysAuthorization() {
        MockCLLocationManager.status = alwaysUseRequestOverride

    }
    
    
}

#endif
