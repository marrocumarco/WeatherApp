//
//  FetchWeathersListUseCase.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

protocol FetchWeathersListUseCase {
    func fetchWeathersList() async throws -> [Weather]
}
