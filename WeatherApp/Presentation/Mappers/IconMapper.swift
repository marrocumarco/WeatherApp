//
//  IconMapper.swift
//  WeatherApp
//
//  Created by marrocumarco on 14/12/2025.
//


struct IconMapper {
    static func iconName(for weatherClass: WeatherClass) -> String {
        switch weatherClass {
        case .bolt:
            return "cloud.bolt"
        case .drizzle:
            return "cloud.drizzle"
        case .sunRain:
            return "cloud.sun.rain"
        case .snow:
            return "cloud.snow"
        case .rain:
            return "cloud.rain"
        case .fog:
            return "cloud.fog"
        case .sun:
            return "sun.max"
        case .cloudSun:
            return "cloud.sun"
        case .cloud:
            return "cloud"
        }
    }
}
