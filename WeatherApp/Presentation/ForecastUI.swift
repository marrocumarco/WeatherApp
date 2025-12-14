//
//  ForecastUI.swift
//  WeatherApp
//
//  Created by marrocumarco on 14/12/2025.
//

import Foundation

struct ForecastUI: Identifiable {
    var id: String { time + temperature }
    let time: String
    let temperature: String
    let iconName: String
    
    static func from(forecast: Forecast) -> Self {
        ForecastUI(
            time: forecast.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))),
            temperature: String(format: "%.1f°", forecast.temperature),
            iconName: IconMapper.iconName(for: forecast.weatherClass)
        )
    }
}
