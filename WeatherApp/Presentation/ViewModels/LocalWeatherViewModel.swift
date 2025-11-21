//
//  LocalWeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class LocalWeatherViewModel: WeatherViewModel, LocationProviderDelegate {
    
    internal init(weather: WeatherUI, weatherUseCase: any FetchWeatherUseCase, forecastUseCase: any FetchForecastUseCase, locationProvider: LocationProvider) {
        self.weather = weather
        self.weatherUseCase = weatherUseCase
        self.forecastUseCase = forecastUseCase
        self.locationProvider = locationProvider
        self.locationProvider.locationProviderDelegate = self
        fetchTodayForecastBy(weather.locationName)
    }
    
    private let weatherUseCase: FetchWeatherUseCase
    private let forecastUseCase: FetchForecastUseCase
    
    private let locationProvider: LocationProvider
    
    private(set) var weather: WeatherUI? {
        didSet {
            if let weather {
                fetchTodayForecastBy(weather.locationName)
            }
        }
    }
    
    private(set) var forecast: [ForecastUI] = []
    
    func fetchWeatherBy(_ location: Coordinates) {
        Task {
            do {
                let weather = try await weatherUseCase.fetchWeatherFor(location)
                self.weather = WeatherUI.from(weather: weather)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchWeatherByCityName(_ cityName: String) {}
    
    func fetchTodayForecastBy(_ location: Coordinates) {
        Task {
            do {
                forecast = try await forecastUseCase.fetchTodayForecastFor(location).map{ ForecastUI.from(forecast: $0) }
            } catch {
                print(error)
            }
        }
    }
    
    func fetchTodayForecastBy(_ cityName: String) {
        Task {
            do {
                forecast = try await forecastUseCase.fetchTodayForecastFor(cityName).map{ ForecastUI.from(forecast: $0) }
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - LocationProviderDelegate
    func onLocationAvailable(coordinates: Coordinates) {
        fetchWeatherBy(coordinates)
        fetchTodayForecastBy(coordinates)
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

struct WeatherUI: Identifiable, Hashable {
    var id: String { hashValue.description }
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
            weatherDescription: weather.mainDescription.capitalized,
            weatherDetails: weather.detailedDescription.capitalized,
            temperature: "\(Int(weather.temperature.rounded(.down)))°C",
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
