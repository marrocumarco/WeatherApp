//
//  WeatherListViewModelImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class WeatherListViewModelImpl: WeatherListViewModel, LocationProviderDelegate {

    private let weatherUseCase: WeatherUseCase
    
    var weathersList: [WeatherUI] = []

    private(set) var weatherDetail: WeatherUI?
    
    private(set) var forecastList: [ForecastUI] = []
    
    let locationProvider: LocationProvider
    
    internal init(weatherUseCase: any WeatherUseCase, locationProvider: LocationProvider) {
        self.weatherUseCase = weatherUseCase
        self.locationProvider = locationProvider
        self.locationProvider.locationProviderDelegate = self
    }
    
    func onSearchCompleted(cityName: String) {
        Task {
            do {
                let cityWeather = try await fetchWeatherByCityName(cityName)
                weathersList.append(cityWeather)
            } catch {
                
            }
        }
    }

    private func fetchWeatherByCityName(_ cityName: String) async throws -> WeatherUI {
        let weather = try await weatherUseCase.fetchWeatherFor(cityName)
        return WeatherUI.from(weather: weather)
    }
    
    private func fetchForecastByCityName(_ cityName: String) async throws -> [ForecastUI] {
        let forecastList = try await weatherUseCase.fetchTodayForecastFor(cityName)
        return forecastList.map {
            ForecastUI.from(forecast: $0)
        }
    }
    
    func onWeatherSelected(weather: WeatherUI) {
        Task {
            weatherDetail = try await fetchWeatherByCityName(weather.locationName)
            forecastList = try await fetchForecastByCityName(weather.locationName)
        }
    }
    
    private func fetchWeatherBy(_ location: Coordinates) async throws -> WeatherUI {
        let weather = try await weatherUseCase.fetchWeatherFor(location)
        return WeatherUI.from(weather: weather)
    }
    
    // MARK: - LocationProviderDelegate
    func onLocationAvailable(coordinates: Coordinates) {
        Task {
            do {
                let currentLocationWeather = try await fetchWeatherBy(coordinates)
                if weathersList.contains(currentLocationWeather) {
                    weathersList.removeAll { $0 == currentLocationWeather }
                }
                weathersList.append(currentLocationWeather)
            } catch {
                // TODO: - show error on UI
            }
        }
    }
}
