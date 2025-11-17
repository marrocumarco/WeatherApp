//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class WeatherListViewModel: LocationProviderDelegate {
    private let weatherUseCase: WeatherUseCase
    
    var weathersList: [WeatherUI] = []

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

    private func fetchWeatherBy(_ location: Coordinates) async throws -> WeatherUI {
        let weather = try await weatherUseCase.fetchWeatherFor(location)
        return WeatherUI.from(weather: weather)
    }
    
    private func fetchWeatherByCityName(_ cityName: String) async throws -> WeatherUI {
        let weather = try await weatherUseCase.fetchWeatherFor(cityName)
        return WeatherUI.from(weather: weather)
    }
    
    // MARK: - LocationProviderDelegate
    func onLocationAvailable(coordinates: Coordinates) {
        Task {
            do {
                let currentLocationWeather = try await fetchWeatherBy(coordinates)
                weathersList.append(currentLocationWeather)
            } catch {
                // TODO: - show error on UI
            }
        }
    }
}
