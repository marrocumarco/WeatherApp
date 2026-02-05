//
//  ForecastApi.swift
//  WeatherApp
//
//  Created by maomar on 15/11/25.
//

import Foundation

struct ForecastApi: Decodable {
    let date: Int
    let main: ForecastMain
    let weather: [WeatherApi]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
}
