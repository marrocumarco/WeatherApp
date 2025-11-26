//
//  WeatherListViewModelImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation
import SwiftUI

@Observable
final class WeatherListViewModelImpl: WeatherListViewModel, LocationProviderDelegate {

    private let weatherUseCase: FetchWeatherUseCase

    private let forecastUseCase: FetchForecastUseCase

    private let saveLocationsUseCase: SaveLocationsUseCase

    private let fetchWeatherListUseCase: FetchWeathersListUseCase

    var weathersList: [WeatherUI] = []

    var locationSuggestions: [String]?

    private(set) var weatherDetail: WeatherUI?

    private(set) var forecastList: [ForecastUI] = []

    private let locationProvider: LocationProvider

    private var suggestionsProvider: SuggestionsProvider

    internal init(
        weatherUseCase: any FetchWeatherUseCase,
        forecastUseCase: any FetchForecastUseCase,
        fetchWeatherListUseCase: any FetchWeathersListUseCase,
        saveLocationsUseCase: any SaveLocationsUseCase,
        locationProvider: LocationProvider,
        suggestionsProvider: SuggestionsProvider
    ) {
        self.weatherUseCase = weatherUseCase
        self.forecastUseCase = forecastUseCase
        self.fetchWeatherListUseCase = fetchWeatherListUseCase
        self.saveLocationsUseCase = saveLocationsUseCase
        self.locationProvider = locationProvider
        self.suggestionsProvider = suggestionsProvider
        self.suggestionsProvider.delegate = self
    }

    func onSearchTextChanged(searchText: String) {
        suggestionsProvider.getSuggestions(searchString: searchText)
    }

    func onSearchCompleted(cityName: String) {
        locationSuggestions = []
        Task {
            do {
                let cityWeather = try await fetchWeatherByCityName(cityName)
                weathersList.append(cityWeather)
                try saveLocations()
            } catch {

            }
        }
    }
    
    fileprivate func saveLocations() throws {
        try saveLocationsUseCase.save(locations: weathersList.filter { !$0.isCurrentLocation }.map(\.locationName))
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

    private func fetchWeatherBy(_ location: Coordinates, isCurrentLocation: Bool) async throws -> WeatherUI {
        let weather = try await weatherUseCase.fetchWeatherFor(location)
        return WeatherUI.from(weather: weather, isCurrentLocation: isCurrentLocation)
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

    func moveItems(from source: IndexSet, to destination: Int) {
        do {
            weathersList.move(fromOffsets: source, toOffset: destination)
            try saveLocations()
        } catch {
            
        }
    }

    func deleteItems(at offsets: IndexSet) {
        do {
            weathersList.remove(atOffsets: offsets)
            try saveLocations()
        } catch {
            
        }
    }

    // MARK: - LocationProviderDelegate
    func onLocationAvailable(coordinates: Coordinates) {
        Task {
            do {
                let currentLocationWeather = try await fetchWeatherBy(coordinates, isCurrentLocation: true)
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

extension WeatherListViewModelImpl: SuggestionsProviderDelegate {
    func onSuggestionsReceived(result: [String]) {
        locationSuggestions = result
    }
    
    func onError(error: any Error) {

    }
}
