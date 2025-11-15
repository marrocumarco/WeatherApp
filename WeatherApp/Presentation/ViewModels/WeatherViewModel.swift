//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol WeatherViewModel: AnyObject {
    func fetchWeatherByLocation()
    func fetchWeatherByCityName(_ cityName: String)
    func fetchTodayForecastByLocation()
    var forecast: [ForecastUI] { get }
    var weather: WeatherUI? { get }
    var searchMode: SearchMode { get }
}

enum SearchMode {
    case location
    case cityName
}
