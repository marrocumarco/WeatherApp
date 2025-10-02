//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol WeatherViewModel: AnyObject {
    var locationName: String { get }
    var weatherDescription: String { get }
    var weatherDetails: String { get }
    var temperature: String { get }
    var minimumTemperature: String { get }
    var maximumTemperature: String { get }
    func fetchWeatherByLocation()
    func fetchWeatherByCityName(_ cityName: String)
    var searchMode: SearchMode { get }
}

enum SearchMode {
    case location
    case cityName
}
