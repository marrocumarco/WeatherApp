//
//  WeatherViewModelMock.swift
//  WeatherApp
//
//  Created by marrocumarco on 12/11/2025.
//

import Foundation

public class WeatherViewModelMock: WeatherViewModel {
    var forecast: [ForecastUI] = []

    func fetchTodayForecastByLocation() {
    }

    var locationName: String = "ROMAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    var weatherDescription: String = "weatherDescription: Fa freddisssssiiimoooooooooooooo"

    var weatherDetails: String = "weatherDetails: Fa freddisssssiiimoooooooooooooo"

    var temperature: String = "110° C"

    var minimumTemperature: String = "-110° C"

    var maximumTemperature: String = "300° F"

    func fetchWeatherByLocation() {
    }
    
    func fetchWeatherByCityName(_ cityName: String) {
    }
    
    var searchMode: SearchMode = .cityName
}
