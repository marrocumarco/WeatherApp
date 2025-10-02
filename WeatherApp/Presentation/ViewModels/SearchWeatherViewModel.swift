//
//  SearchWeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class SearchWeatherViewModel: WeatherViewModel {

    internal init(weatherUseCase: any WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    private(set) var weather: Weather? {
        didSet {
            updateWeatherProperties()
        }
    }
    
    private let weatherUseCase: WeatherUseCase
    
    var searchMode: SearchMode = .cityName
    
    func fetchWeatherByLocation() {}
    
    func fetchWeatherByCityName(_ cityName: String) {
        Task {
            do {
                weather = try await weatherUseCase.fetchWeatherFor(cityName)
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
    
    private func updateWeatherProperties() {
        guard let weather else { return }
        self.locationName = weather.name
        self.weatherDescription = weather.mainDescription
        self.weatherDetails = weather.detailedDescription
        self.temperature = "\(Int(weather.temperature.rounded(.down)))°C"
        self.minimumTemperature = "MIN \(Int(weather.minimumTemperature.rounded(.down)))°C"
        self.maximumTemperature = "MAX \(Int(weather.maximumTemperature.rounded(.down)))°C"
    }
}
