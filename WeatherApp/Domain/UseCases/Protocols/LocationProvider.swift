//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol LocationProvider: AnyObject {
    var locationProviderDelegate: LocationProviderDelegate? { get set }
}
