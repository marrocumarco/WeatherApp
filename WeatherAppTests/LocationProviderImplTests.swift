//
//  LocationProviderImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 10/01/2026.
//

import Testing
@testable import WeatherApp
import CoreLocation

class MockLocationManager: LocationManager {
    internal init(authorizationStatus: CLAuthorizationStatus) {
        self.authorizationStatus = authorizationStatus
    }
    
    var delegate: (any CLLocationManagerDelegate)?
    
    func requestWhenInUseAuthorization() {

    }
    
    func requestLocation() {

    }
    
    var authorizationStatus: CLAuthorizationStatus
}

struct LocationProviderImplTests {

    @Test func `instantiate location provider`() async throws {
        let locationManager = MockLocationManager(authorizationStatus: .authorizedAlways)
        let provider = await LocationProviderImpl(locationManager: locationManager)
    }

}
