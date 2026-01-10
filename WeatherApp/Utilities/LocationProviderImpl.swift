//
//  LocationProviderImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import CoreLocation
import Foundation

protocol LocationProviderDelegate: AnyObject {
    func onLocationAvailable(coordinates: Coordinates)
}

protocol LocationManager: AnyObject {
    var delegate: (any CLLocationManagerDelegate)? { get set }
    func requestWhenInUseAuthorization()
    func requestLocation()
    var authorizationStatus: CLAuthorizationStatus { get }
}

extension CLLocationManager: LocationManager {}

final class LocationProviderImpl: NSObject, LocationProvider, CLLocationManagerDelegate {
    
    internal init(locationManager: any LocationManager) {
        self.locationManager = locationManager
    }
    
    weak var locationProviderDelegate: LocationProviderDelegate? {
        didSet {
            configureLocationManager()
        }
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    let locationManager: LocationManager

    func locationManager(_ f: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse,
           !locations.isEmpty {
            let coordinates = Coordinates(
                latitude: locations.first!.coordinate.latitude,
                longitude: locations.first!.coordinate.longitude
            )
            locationProviderDelegate?.onLocationAvailable(coordinates: coordinates)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

enum LocationProviderError: Error {
    case cannotGetLocation
}
