//
//  WeatherUI.swift
//  WeatherApp
//
//  Created by marrocumarco on 14/12/2025.
//

import SwiftUI

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
            iconName: IconMapper.iconName(for: weather.weatherClass),
            gradientColors: GradientMapper.gradient(for: weather.weatherClass)
        )
    }
}
