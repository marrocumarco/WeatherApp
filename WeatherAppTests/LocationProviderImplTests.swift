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

class MockLocationProviderDelegate: LocationProviderDelegate {

    var delegateCalled = false
    func onLocationAvailable(coordinates: Coordinates) {
        delegateCalled = true
    }
}

struct LocationProviderImplTests {

    let delegate = MockLocationProviderDelegate()

    @Test func `instantiate location provider`() async throws {
        let locationManager = MockLocationManager(authorizationStatus: .authorizedAlways)
        let _ = await LocationProviderImpl(locationManager: locationManager)
    }

    @Test("locationProviderDelegate called when location authorized", arguments: [CLAuthorizationStatus.authorizedAlways, CLAuthorizationStatus.authorizedWhenInUse])
    @MainActor
    func locationProviderDelegateCalled(authorizationStatus: CLAuthorizationStatus) async throws {
        let locationManager = MockLocationManager(authorizationStatus: authorizationStatus)

        let locationProvider = LocationProviderImpl(locationManager: locationManager)
        locationProvider.locationProviderDelegate = delegate
        locationManager.delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [CLLocation()])

        #expect(delegate.delegateCalled)
    }

}
