//
//  MockLocationManager.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import MapKit

#if DEBUG
protocol LocationManager {
    var location:CLLocation? {get}
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
}

class MockCLLocationManager:CLLocationManager{
    var authStatus:CLAuthorizationStatus = .notDetermined
    func authorizationStatus() -> CLAuthorizationStatus{
        return authStatus
    }
    override func requestAlwaysAuthorization() {
        self.authStatus = .authorizedAlways
    }
    override func requestWhenInUseAuthorization() {
        self.authStatus = .authorizedWhenInUse
    } 
}
#endif
