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

    var weatherDetail: WeatherUI?
    
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
    
    func onWeatherSelected(weather: WeatherUI) {
        weatherDetail = weather
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
