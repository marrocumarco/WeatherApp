//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by maomar on 18/11/25.
//

import Foundation

protocol WeatherListViewModel {
    var weathersList: [WeatherUI] { get set }
    var forecastList: [ForecastUI] { get }
    var weatherDetail: WeatherUI? { get }
    func onSearchCompleted(cityName: String)
    func onWeatherSelected(weather: WeatherUI)
}
