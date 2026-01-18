//
//  MockLocationManager.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

@testable import WeatherApp
import CoreLocation

class MockLocationManager: LocationManager {
    internal init(authorizationStatus: CLAuthorizationStatus) {
        self.authorizationStatus = authorizationStatus
    }
    
    var delegate: (any CLLocationManagerDelegate)?
    func requestWhenInUseAuthorization() {}
    func requestLocation() {}
    var authorizationStatus: CLAuthorizationStatus
}
