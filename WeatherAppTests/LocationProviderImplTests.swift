//
//  LocationProviderImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 10/01/2026.
//

import Testing
@testable import WeatherApp
import CoreLocation


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

    @Test("locationProviderDelegate called when location array is empty")
    @MainActor
    func locationProviderDelegate_onLocationErrorCalled() async throws {
        let locationManager = MockLocationManager(authorizationStatus: .authorizedAlways)

        let locationProvider = LocationProviderImpl(locationManager: locationManager)
        locationProvider.locationProviderDelegate = delegate
        locationManager.delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [])

        #expect(delegate.onLocationErrorCalled)
        #expect(delegate.error as? LocationProviderError == .locationNotFound)
    }

    @Test("locationProviderDelegate called when location manager fails")
    @MainActor
    func locationProviderDelegate_locationManagerFails_onLocationErrorCalled() async throws {

        Log.logEngine = EmptyLogEngine()
        struct MockError: Error {}

        let locationManager = MockLocationManager(authorizationStatus: .authorizedAlways)

        let locationProvider = LocationProviderImpl(locationManager: locationManager)
        locationProvider.locationProviderDelegate = delegate
        locationManager.delegate?.locationManager?(CLLocationManager(), didFailWithError: MockError())

        #expect(delegate.onLocationErrorCalled)
        #expect(delegate.error as? LocationProviderError == .locationManagerError)
    }
}
