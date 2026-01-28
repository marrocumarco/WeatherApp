//
//  DependencyInjectionContainer.swift
//  WeatherApp
//
//  Created by marrocumarco on 21/01/2026.
//

import MapKit
import CoreLocation

struct DependencyInjectionContainer {

    private let localDataSource = LocalDataSourceImpl(userDefaults: .standard)
    private let weatherRepository: any WeatherRepository
    private let locationRepository: any LocationsRepository
    private let geocoder = GeocoderImpl()
    private let weatherUseCase: FetchWeatherUseCaseImpl
    private let forecastUseCase: FetchForecastUseCaseImpl
    private let fetchWeatherListUseCase: FetchWeathersListUseCaseImpl
    private let saveLocationsUseCase: any SaveLocationsUseCase
    private let suggestionProvider: SuggestionsProvider = SuggestionsProviderImpl(completer: MKLocalSearchCompleter())

    init() throws {

        guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
           let dict = NSDictionary(contentsOf: url) as? [String: Any] else {
            throw DependencyInjectionContainerError()
        }

        let networkConfiguration = try ConfigurationReaderImpl().readNetworkConfiguration(from: dict)

        weatherRepository = WeatherRepositoryImpl(
            apiClient: try ApiClientImpl(networkSession: URLSession.shared, networkConfiguration: networkConfiguration)
        )
        weatherUseCase = FetchWeatherUseCaseImpl(weatherRepository: weatherRepository, geocoder: geocoder)
        forecastUseCase = FetchForecastUseCaseImpl(weatherRepository: weatherRepository, geocoder: geocoder)
        locationRepository = LocationsRepositoryImpl(localDataSource: localDataSource)
        fetchWeatherListUseCase = FetchWeathersListUseCaseImpl(locationsRepository: locationRepository, weatherRepository: weatherRepository)
        saveLocationsUseCase = SaveLocationsUseCaseImpl(locationsRepository: locationRepository)
    }

    func getWeatherListViewModel() -> WeatherListViewModel {
        WeatherListViewModelImpl(
            weatherUseCase: weatherUseCase,
            forecastUseCase: forecastUseCase,
            fetchWeatherListUseCase: fetchWeatherListUseCase,
            saveLocationsUseCase: saveLocationsUseCase,
            locationProvider: locationProvider,
            suggestionsProvider: suggestionProvider
        )
    }

    struct DependencyInjectionContainerError: Error {}
}
