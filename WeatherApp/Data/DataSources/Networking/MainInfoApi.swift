//
//  MainInfoApi.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct MainInfoApi: Decodable {
    let temperature: Double
    let feelsLike: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}
