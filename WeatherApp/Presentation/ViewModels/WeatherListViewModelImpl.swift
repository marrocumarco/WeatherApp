//
//  WeatherListViewModelImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class WeatherListViewModelImpl: WeatherListViewModel, LocationProviderDelegate {
    private let weatherUseCase: FetchWeatherUseCase

    private let forecastUseCase: FetchForecastUseCase

    private let saveLocationsUseCase: SaveLocationsUseCase
    
    private let fetchWeatherListUseCase: FetchWeathersListUseCase

    var weathersList: [WeatherUI] = []

    private(set) var weatherDetail: WeatherUI?

    private(set) var forecastList: [ForecastUI] = []

    let locationProvider: LocationProvider

    internal init(weatherUseCase: any FetchWeatherUseCase,
                  forecastUseCase: any FetchForecastUseCase,
                  fetchWeatherListUseCase: any FetchWeathersListUseCase,
                  saveLocationsUseCase: any SaveLocationsUseCase,
                  locationProvider: LocationProvider) {
        self.weatherUseCase = weatherUseCase
        self.forecastUseCase = forecastUseCase
        self.fetchWeatherListUseCase = fetchWeatherListUseCase
        self.saveLocationsUseCase = saveLocationsUseCase
        self.locationProvider = locationProvider
    }

    func onSearchCompleted(cityName: String) {
        Task {
            do {
                let cityWeather = try await fetchWeatherByCityName(cityName)
                weathersList.append(cityWeather)
                try saveLocationsUseCase.save(locations: weathersList.map(\.locationName))
            } catch {

            }
        }
    }

    private func fetchWeatherByCityName(_ cityName: String) async throws -> WeatherUI {
        let weather = try await weatherUseCase.fetchWeatherFor(cityName)
        return WeatherUI.from(weather: weather)
    }

    private func fetchForecastByCityName(_ cityName: String) async throws -> [ForecastUI] {
        let forecastList = try await forecastUseCase.fetchTodayForecastFor(cityName)
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
    
    func viewDidAppear() {
        self.locationProvider.locationProviderDelegate = self
        fetchWeatherList()
    }
    
    private func fetchWeatherList() {
        Task {
            do {
                let weathersList = try await fetchWeatherListUseCase.fetchWeathersList().map {
                    WeatherUI.from(weather: $0)
                }
                self.weathersList.append(contentsOf: weathersList)
            } catch {
                // TODO: - show error on UI
            }
        }
    }
    
    // MARK: - LocationProviderDelegate
    func onLocationAvailable(coordinates: Coordinates) {
        Task {
            do {
                let currentLocationWeather = try await fetchWeatherBy(coordinates)
                if weathersList.contains(currentLocationWeather) {
                    weathersList.removeAll { $0 == currentLocationWeather }
                }
                weathersList.insert(currentLocationWeather, at: 0)
            } catch {
                // TODO: - show error on UI
            }
        }
    }
}
