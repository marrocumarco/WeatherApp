//
//  WeatherClassProvider.swift
//  WeatherApp
//
//  Created by marrocumarco on 10/12/2025.
//

import Foundation

struct WeatherClassProvider {
    static func weatherClass(for code: Int) -> WeatherClass {
        switch code {
        case 200...299:
            return .bolt
        case 300...399:
            return .drizzle
        case 500...504:
            return .sunRain
        case 511:
            return .snow
        case 520...599:
            return .rain
        case 600...699:
            return .snow
        case 700...799:
            return .fog
        case 800:
            return .sun
        case 801:
            return .cloudSun
        case 802...804:
            return .cloud
        default:
            return .cloud
        }
    }
}
