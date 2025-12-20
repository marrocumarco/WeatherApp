//
//  Weather.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct Weather: Equatable {
    let id: Int
    let weatherClass: WeatherClass
    let date: Date
    let timezone: TimeZone
    let name: String
    let mainDescription: String
    let detailedDescription: String
    let temperature: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let pressure: Int
    let humidity: Int
    let sunrise: Date
    let sunset: Date
}

enum WeatherClass {
    case bolt
    case drizzle
    case sunRain
    case snow
    case rain
    case fog
    case sun
    case cloudSun
    case cloud
}
