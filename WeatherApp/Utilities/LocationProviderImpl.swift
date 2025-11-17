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

final class LocationProviderImpl: NSObject, LocationProvider, CLLocationManagerDelegate {
   
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    weak var locationProviderDelegate: LocationProviderDelegate?
    
    let locationManager = CLLocationManager()
        
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
