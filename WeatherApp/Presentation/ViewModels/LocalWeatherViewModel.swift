//
//  LocalWeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct ForecastUI: Identifiable {
    var id: String { time + temperature }
    let time: String
    let temperature: String
    let iconName: String
    
    static func from(forecast: Forecast) -> Self {
        ForecastUI(
            time: forecast.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))),
            temperature: String(format: "%.1f°", forecast.temperature),
            iconName: IconProvider.iconName(for: forecast.weatherClass)
        )
    }
}

struct WeatherUI: Identifiable, Hashable {
    var id: String { hashValue.description }
    let isCurrentLocation: Bool
    let locationName: String
    let time: String
    let weatherDescription: String
    let weatherDetails: String
    let temperature: String
    let minimumTemperature: String
    let maximumTemperature: String
    let iconName: String
    let gradientColors: Gradient

    static func from(weather: Weather, isCurrentLocation: Bool = false) -> Self {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.calendar = Calendar.current
        formatter.timeZone = weather.timezone
        formatter.dateFormat = "HH:mm"
        return WeatherUI(
            isCurrentLocation: isCurrentLocation,
            locationName: weather.name,
            time: isCurrentLocation ? "My Location" : formatter.string(from: weather.date),
            weatherDescription: weather.mainDescription.capitalized,
            weatherDetails: weather.detailedDescription.capitalized,
            temperature: "\(Int(weather.temperature.rounded(.down)))°",
            minimumTemperature: "\(Int(weather.minimumTemperature.rounded(.down)))°",
            maximumTemperature: "\(Int(weather.maximumTemperature.rounded(.down)))°",
            iconName: IconProvider.iconName(for: weather.weatherClass),
            gradientColors: GradientProvider.gradient(for: weather.weatherClass)
        )
    }
}

struct GradientProvider {
    static func gradient(for weatherClass: WeatherClass) -> Gradient {
        switch weatherClass {
        case .bolt:
            return Gradient(colors: [
                .indigo,
                .black.opacity(0.85)
            ])
        case .drizzle:
            return Gradient(colors: [
                .gray.opacity(0.5),
                .blue.opacity(0.4)
            ])
        case .sunRain:
            return Gradient(colors: [
                .cyan,
                .indigo
            ])
        case .snow:
            return Gradient(colors: [
                .white,
                .cyan.opacity(0.6)
            ])
        case .rain:
            return Gradient(colors: [
                .blue.opacity(0.8),
                .indigo
            ])
        case .fog:
            return Gradient(colors: [
                .gray.opacity(0.7),
                .gray.opacity(0.3)
            ])
        case .sun:
            return Gradient(colors: [
                .yellow,
                .orange
            ])
        case .cloudSun:
            return Gradient(colors: [
                .blue,
                .orange.opacity(0.5)
            ])
        case .cloud:
            return Gradient(colors: [
                .gray,
                .blue.opacity(0.2)
            ])
        }
    }
}

struct IconProvider {
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
        default:
            return "cloud"
        }
    }
}
