//
//  WeatherListViewModelImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 29/01/2026.
//

import Testing
@testable import WeatherApp
import Foundation

struct FetchWeatherUseCaseMock: FetchWeatherUseCase {
    func fetchWeatherFor(_ location: Coordinates) async throws -> Weather {
        Weather(id: 511, weatherClass: .snow, date: Date(timeIntervalSince1970: 1765916286), timezone: TimeZone(secondsFromGMT: 0)!, name: "Paris", mainDescription: "Sunny", detailedDescription: "Description says sunny", temperature: 20, minimumTemperature: 5, maximumTemperature: 27, pressure: 1800, humidity: 55, sunrise: Date(timeIntervalSince1970: 1765869743), sunset: Date(timeIntervalSince1970: 1765905743))
    }
    
    func fetchWeatherFor(_ cityName: String) async throws -> Weather {
        Weather(id: 511, weatherClass: .snow, date: Date(timeIntervalSince1970: 1765916286), timezone: TimeZone(secondsFromGMT: 0)!, name: "Paris", mainDescription: "Sunny", detailedDescription: "Description says sunny", temperature: 20, minimumTemperature: 5, maximumTemperature: 27, pressure: 1800, humidity: 55, sunrise: Date(timeIntervalSince1970: 1765869743), sunset: Date(timeIntervalSince1970: 1765905743))
    }
}

struct FetchForecastUseCaseMock: FetchForecastUseCase {
    func fetchTodayForecastFor(_ location: Coordinates) async throws -> [Forecast] {
        []
    }
    
    func fetchTodayForecastFor(_ cityName: String) async throws -> [Forecast] {
        []
    }
}

struct FetchWeatherListUseCaseMock: FetchWeathersListUseCase {
    func fetchWeathersList() async throws -> [Weather] {
        []
    }
}

struct SaveLocationsUseCaseMock: SaveLocationsUseCase {
    func save(locations: [String]) throws {
        
    }
}

class LocationProviderMock: LocationProvider {
    var locationProviderDelegate: (any LocationProviderDelegate)?
    

}

class SuggestionsProviderMock: SuggestionsProvider {
    func getSuggestions(searchString: String) {

    }
    
    var delegate: (any SuggestionsProviderDelegate)?

}

struct WeatherListViewModelImplTests {

    let sut: WeatherListViewModelImpl!

    init() {
        self.sut = WeatherListViewModelImpl(weatherUseCase: FetchWeatherUseCaseMock(), forecastUseCase: FetchForecastUseCaseMock(), fetchWeatherListUseCase: FetchWeatherListUseCaseMock(), saveLocationsUseCase: SaveLocationsUseCaseMock(), locationProvider: LocationProviderMock(), suggestionsProvider: SuggestionsProviderMock())
    }
//    @Test func <#test function name#>() async throws {
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }

}
