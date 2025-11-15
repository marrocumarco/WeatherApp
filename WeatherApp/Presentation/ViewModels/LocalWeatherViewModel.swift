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
    
    var searchMode: SearchMode = .location
    
    private(set) var weather: WeatherUI?
    
    private(set) var forecast: [ForecastUI] = []
    
    func fetchWeatherByLocation() {
        Task {
            do {
                let weather = try await weatherUseCase.fetchWeatherForCurrentLocation()
                self.weather = WeatherUI.from(weather: weather)
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
    let iconName: String
    
    static func from(forecast: Forecast) -> Self {
        ForecastUI(
            time: forecast.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))),
            temperature: String(format: "%.1f°", forecast.temperature),
            iconName: IconProvider.iconName(for: forecast.iconId)
        )
    }
}

struct WeatherUI {
    let locationName: String
    let weatherDescription: String
    let weatherDetails: String
    let temperature: String
    let minimumTemperature: String
    let maximumTemperature: String
    let iconName: String
    
    static func from(weather: Weather) -> Self {
        WeatherUI(
            locationName: weather.name,
            weatherDescription: weather.mainDescription,
            weatherDetails: weather.detailedDescription,
            temperature: "\(Int(weather.temperature.rounded(.down)))° C",
            minimumTemperature: "\(Int(weather.minimumTemperature.rounded(.down)))°",
            maximumTemperature: "\(Int(weather.maximumTemperature.rounded(.down)))°",
            iconName: IconProvider.iconName(for: weather.id)
        )
    }
}

struct IconProvider {
    static func iconName(for code: Int) -> String {
        switch code {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.sun.rain"
        case 511:
            return "cloud.snow"
        case 520...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
