//
//  FetchForecastUseCase.swift
//  WeatherApp
//
//  Created by maomar on 21/11/25.
//

import Foundation

protocol FetchForecastUseCase {
    func fetchTodayForecastFor(_ location: Coordinates) async throws -> [Forecast]
    func fetchTodayForecastFor(_ cityName: String) async throws -> [Forecast]
}
