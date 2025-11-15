//
//  SearchWeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class SearchWeatherViewModel: WeatherViewModel {

    var forecast: [ForecastUI] = []

    func fetchTodayForecastByLocation() {
    }

    internal init(weatherUseCase: any WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    private(set) var weather: WeatherUI?
    
    private let weatherUseCase: WeatherUseCase
    
    var searchMode: SearchMode = .cityName
    
    func fetchWeatherByLocation() {}
    
    func fetchWeatherByCityName(_ cityName: String) {
        Task {
            do {
                let weather = try await weatherUseCase.fetchWeatherFor(cityName)
                self.weather = WeatherUI.from(weather: weather)
            } catch {
                print(error)
            }
        }
    }
    
    var locationName: String = ""
    
    var weatherDescription: String = ""
    
    var weatherDetails: String = ""
    
    var temperature: String = ""
    
    var minimumTemperature: String = ""
    
    var maximumTemperature: String = ""
}
