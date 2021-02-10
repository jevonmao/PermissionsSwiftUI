//
//  MockLocationManager.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import MapKit

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? {get set}
    func authorizationStatus() -> CLAuthorizationStatus
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
}

extension CLLocationManager:LocationManager{
    func authorizationStatus() -> CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }
    
    
}
struct MockCLLocationManager:LocationManager{
    weak var delegate: CLLocationManagerDelegate?
    
    private static var status:CLAuthorizationStatus = .notDetermined
    func authorizationStatus() -> CLAuthorizationStatus {
        MockCLLocationManager.status
    }
    
    func requestWhenInUseAuthorization() {
        MockCLLocationManager.status = .authorizedWhenInUse
    }
    
    func requestAlwaysAuthorization() {
        MockCLLocationManager.status = .authorizedAlways

    }
    
    
}
//class MockCLLocationManager:CLLocationManager{
//    var authStatus:CLAuthorizationStatus = .notDetermined
//    func authorizationStatus() -> CLAuthorizationStatus{
//        return authStatus
//    }
//    override func requestAlwaysAuthorization() {
//        self.authStatus = .authorizedAlways
//    }
//    override func requestWhenInUseAuthorization() {
//        self.authStatus = .authorizedWhenInUse
//    }
//}

