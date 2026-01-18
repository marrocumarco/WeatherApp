//
//  MockLocationProviderDelegate.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

@testable import WeatherApp

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
