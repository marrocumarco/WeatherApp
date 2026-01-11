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

    var onLocationAvailableCalled = false
    var onLocationErrorCalled = false
    private(set) var error: Error?

    func onLocationAvailable(coordinates: Coordinates) {
        onLocationAvailableCalled = true
    }

    func onLocationError(error: Error) {
        onLocationErrorCalled = true
        self.error = error
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
    func locationProviderDelegate_onLocationAvailableCalledCalled(authorizationStatus: CLAuthorizationStatus) async throws {
        let locationManager = MockLocationManager(authorizationStatus: authorizationStatus)

        let locationProvider = LocationProviderImpl(locationManager: locationManager)
        locationProvider.locationProviderDelegate = delegate
        locationManager.delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [CLLocation()])

        #expect(delegate.onLocationAvailableCalled)
    }

    @Test("locationProviderDelegate called when location not authorized", arguments: [CLAuthorizationStatus.denied, CLAuthorizationStatus.notDetermined])
    @MainActor
    func locationProviderDelegate_onLocationErrorCalled(authorizationStatus: CLAuthorizationStatus) async throws {
        let locationManager = MockLocationManager(authorizationStatus: authorizationStatus)

        let locationProvider = LocationProviderImpl(locationManager: locationManager)
        locationProvider.locationProviderDelegate = delegate
        locationManager.delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [CLLocation()])

        #expect(delegate.onLocationErrorCalled)
        #expect(delegate.error as? LocationProviderError == .locationNotAuthorized)
    }


}
