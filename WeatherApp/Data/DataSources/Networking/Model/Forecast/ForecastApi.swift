//
//  ForecastApi.swift
//  WeatherApp
//
//  Created by maomar on 15/11/25.
//

import Foundation

struct ForecastApi: Decodable {
    let dt: Int
    let main: ForecastMain
    let weather: [WeatherApi]
}
