//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI
import MapKit
import CoreLocation

let locationProvider = LocationProviderImpl(locationManager: CLLocationManager())

@main
struct WeatherApp: App {
    
    init() {
        LoggerWrapper.logEngine = LogEngineImpl(subsystem: Bundle.main.bundleIdentifier!)
        LoggerWrapper.info(message: "WeatherApp is starting", category: .ui)
        
        weatherRepository = WeatherRepositoryImpl(
            apiClient: try! ApiClientImpl(networkSession: URLSession.shared)
        )
        weatherUseCase = FetchWeatherUseCaseImpl(weatherRepository: weatherRepository, geocoder: geocoder)
        forecastUseCase = FetchForecastUseCaseImpl(weatherRepository: weatherRepository, geocoder: geocoder)
        locationRepository = LocationsRepositoryImpl(localDataSource: localDataSource)
        fetchWeatherListUseCase = FetchWeathersListUseCaseImpl(locationsRepository: locationRepository, weatherRepository: weatherRepository)
        saveLocationsUseCase = SaveLocationsUseCaseImpl(locationsRepository: locationRepository)
    }
    
    private let localDataSource = LocalDataSourceImpl()
    private let weatherRepository: any WeatherRepository
    private let locationRepository: any LocationsRepository
    private let geocoder = GeocoderImpl()
    private let weatherUseCase: FetchWeatherUseCaseImpl
    private let forecastUseCase: FetchForecastUseCaseImpl
    private let fetchWeatherListUseCase: FetchWeathersListUseCaseImpl
    private let saveLocationsUseCase: any SaveLocationsUseCase
    private let suggestionProvider: SuggestionsProvider = SuggestionsProviderImpl(completer: MKLocalSearchCompleter())

    var body: some Scene {
        WindowGroup {
            if !isRunningUnitTests() {
                buildMainView()
            } else {
                Text("Running Unit Tests...")
            }
        }
    }

    private func isRunningUnitTests() -> Bool {
        return NSClassFromString("XCTestCase") != nil
    }

    private func buildMainView() -> WeatherListView {
        return WeatherListView(
            viewModel: WeatherListViewModelImpl(
                weatherUseCase: weatherUseCase,
                forecastUseCase: forecastUseCase,
                fetchWeatherListUseCase: fetchWeatherListUseCase,
                saveLocationsUseCase: saveLocationsUseCase,
                locationProvider: locationProvider,
                suggestionsProvider: suggestionProvider
            )
        )
    }
}


