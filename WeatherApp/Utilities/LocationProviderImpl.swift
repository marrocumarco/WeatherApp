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
    func onLocationError(error: Error)
}

protocol LocationManager: AnyObject {
    var delegate: (any CLLocationManagerDelegate)? { get set }
    func requestWhenInUseAuthorization()
    func requestLocation()
    var authorizationStatus: CLAuthorizationStatus { get }
}

extension CLLocationManager: LocationManager {}

final class LocationProviderImpl: NSObject, LocationProvider {

    private let locationManager: LocationManager

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
}

extension LocationProviderImpl: CLLocationManagerDelegate {


    func locationManager(_ f: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isLocationAuthorized,
           !locations.isEmpty {
            let coordinates = getFirstCoordinates(from: locations)
            locationProviderDelegate?.onLocationAvailable(coordinates: coordinates)
        } else {
            locationProviderDelegate?.onLocationError(error: LocationProviderError.locationNotAuthorized)
        }
    }

    private var isLocationAuthorized: Bool { locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse
    }

    private func getFirstCoordinates(from locations: [CLLocation]) -> Coordinates {
        return Coordinates(
            latitude: locations.first!.coordinate.latitude,
            longitude: locations.first!.coordinate.longitude
        )
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

enum LocationProviderError: Error {
    case cannotGetLocation
    case locationNotAuthorized
}
