//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI
let locationProvider = LocationProviderImpl()

@main
struct WeatherApp: App {
    
    init() {
        weatherRepository = WeatherRepositoryImpl(
            apiClient: try! ApiClientImpl(),
            imageLoader: ImageLoaderImpl()
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
    
    var body: some Scene {
        WindowGroup {
            WeatherListView(
                viewModel: WeatherListViewModelImpl(
                    weatherUseCase: weatherUseCase,
                    forecastUseCase: forecastUseCase,
                    fetchWeatherListUseCase: fetchWeatherListUseCase,
                    saveLocationsUseCase: saveLocationsUseCase,
                    locationProvider: locationProvider
                )
            )
        }
    }
}


