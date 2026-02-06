//
//  WeatherClassProvider.swift
//  WeatherApp
//
//  Created by marrocumarco on 10/12/2025.
//

import Foundation

struct WeatherClassProvider {

    private static let weatherClassCodesList: [WeatherClassCodeWrapper] = [
        WeatherClassCodeWrapper(min: 200, max: 299, weatherClass: .bolt),
        WeatherClassCodeWrapper(min: 300, max: 399, weatherClass: .drizzle),
        WeatherClassCodeWrapper(min: 500, max: 504, weatherClass: .sunRain),
        WeatherClassCodeWrapper(min: 511, max: 511, weatherClass: .snow),
        WeatherClassCodeWrapper(min: 520, max: 599, weatherClass: .rain),
        WeatherClassCodeWrapper(min: 600, max: 699, weatherClass: .snow),
        WeatherClassCodeWrapper(min: 700, max: 799, weatherClass: .fog),
        WeatherClassCodeWrapper(min: 800, max: 800, weatherClass: .sun),
        WeatherClassCodeWrapper(min: 801, max: 801, weatherClass: .cloudSun),
        WeatherClassCodeWrapper(min: 802, max: 804, weatherClass: .cloud)
    ]

    static func weatherClass(for code: Int) throws -> WeatherClass {
        if let weatherClass = findWeatherClassInList(code) {
            return weatherClass
        } else {
            throw WeatherClassProviderError.invalidCode
        }
    }

    private static func findWeatherClassInList(_ code: Int) -> WeatherClass? {
        return weatherClassCodesList.first(where: { (code >= $0.min && code <= $0.max) })?.weatherClass
    }

    private struct WeatherClassCodeWrapper {
        let min: Int
        let max: Int
        let weatherClass: WeatherClass
    }

    enum WeatherClassProviderError: Error {
        case invalidCode
    }
}
