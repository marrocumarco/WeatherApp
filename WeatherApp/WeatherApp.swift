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
        repository = WeatherRepositoryImpl(
            apiClient: try! ApiClientImpl(),
            imageLoader: ImageLoaderImpl()
        )
        weatherUseCase = FetchWeatherUseCaseImpl(weatherRepository: repository, geocoder: geocoder)
        forecastUseCase = FetchForecastUseCaseImpl(weatherRepository: repository, geocoder: geocoder)
    }
    
    private let repository: any WeatherRepository
    private let geocoder = GeocoderImpl()
    private let weatherUseCase: FetchWeatherUseCaseImpl
    private let forecastUseCase: FetchForecastUseCaseImpl
        
    var body: some Scene {
        WindowGroup {
            WeatherListView(
                viewModel: WeatherListViewModelImpl(
                    weatherUseCase: weatherUseCase,
                    forecastUseCase: forecastUseCase,
                    locationProvider: locationProvider
                )
            )
        }
    }
}


