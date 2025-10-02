//
//  LocationProviderImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import CoreLocation
import Foundation

final class LocationProviderImpl: NSObject, LocationProvider, CLLocationManagerDelegate {
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    let locationManager = CLLocationManager()

    func getCurrentLocation() throws -> Coordinates {
        guard let location = locationManager.location else {
            throw LocationProviderError.cannotGetLocation
        }
        
        return Coordinates(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

enum LocationProviderError: Error {
    case cannotGetLocation
}
