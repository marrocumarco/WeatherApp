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
    
    private(set) var forecast: [ForecastUI] = []
    
    private func updateWeatherProperties() {
        guard let weather else { return }
        self.locationName = weather.name
        self.weatherDescription = weather.mainDescription
        self.weatherDetails = weather.detailedDescription
        self.temperature = "\(Int(weather.temperature.rounded(.down)))° C"
        self.minimumTemperature = "\(Int(weather.minimumTemperature.rounded(.down)))°"
        self.maximumTemperature = "\(Int(weather.maximumTemperature.rounded(.down)))°"
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
    
    func fetchTodayForecastByLocation() {
        Task {
            do {
                forecast = try await weatherUseCase.fetchTodayForecastForCurrentLocation().map{ForecastUI.from(forecast: $0)}
            } catch {
                print(error)
            }
        }
    }
}

struct ForecastUI: Identifiable {
    var id: String { time + temperature }
    let time: String
    let temperature: String
    
    static func from(forecast: Forecast) -> Self {
        ForecastUI(time: forecast.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))), temperature: String(format: "%.1f°", forecast.temperature))
    }
}
