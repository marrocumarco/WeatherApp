//
//  FetchWeathersListUseCaseImpl.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

struct FetchWeathersListUseCaseImpl: FetchWeathersListUseCase {
    
    let locationsRepository: LocationsRepository
    let weatherRepository: WeatherRepository
    
    func fetchWeathersList() async throws -> [Weather] {
        var weatherList = [Weather]()
        for location in try locationsRepository.getLocations() {
            weatherList.append(try await weatherRepository.fetchWeatherBy(location))
        }
        
        return weatherList
    }
}
