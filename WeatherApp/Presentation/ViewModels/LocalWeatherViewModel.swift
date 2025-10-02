//
//  LocalWeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class LocalWeatherViewModel: WeatherViewModel {

    internal init(weatherUseCase: any WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    private let weatherUseCase: WeatherUseCase
    
    var locationName: String = ""
    
    var searchMode: SearchMode = .location

    var weatherDescription: String = ""

    var weatherDetails: String = ""

    var temperature: String = ""

    var minimumTemperature: String = ""

    var maximumTemperature: String = ""

    
    private(set) var weather: Weather? {
        didSet {
            updateWeatherProperties()
        }
    }
    
    private func updateWeatherProperties() {
        guard let weather else { return }
        self.locationName = weather.name
        self.weatherDescription = weather.mainDescription
        self.weatherDetails = weather.detailedDescription
        self.temperature = "\(Int(weather.temperature.rounded(.down)))°C"
        self.minimumTemperature = "\(Int(weather.minimumTemperature.rounded(.down)))°C"
        self.maximumTemperature = "\(Int(weather.maximumTemperature.rounded(.down)))°C"
    }
    
    func fetchWeatherByLocation() {
        Task {
            do {
                weather = try await weatherUseCase.fetchWeatherForCurrentLocation()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchWeatherByCityName(_ cityName: String) {}
}
