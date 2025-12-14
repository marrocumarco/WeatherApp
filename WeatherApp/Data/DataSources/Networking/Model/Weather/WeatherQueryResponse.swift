//
//  WeatherQueryResponse.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct WeatherQueryResponse: Decodable {
    let name: String
    let dt: Int
    let timezone: Int
    let weather: [WeatherApi]
    let main: MainInfoApi
    let sys: SystemInfoApi

    func toWeather() -> Weather {
        Weather(
            id: weather.first?.id ?? 0,
            weatherClass: WeatherClassProvider.weatherClass(for: weather.first?.id ?? 0),
            date: Date(timeIntervalSince1970: TimeInterval(dt)),
            timezone: TimeZone(secondsFromGMT: timezone) ?? TimeZone.current,
            name: name,
            mainDescription: weather.first?.main ?? "",
            detailedDescription: weather.first?.description ?? "",
            temperature: main.temperature,
            minimumTemperature: main.minimumTemperature,
            maximumTemperature: main.maximumTemperature,
            pressure: main.pressure,
            humidity: main.humidity,
            sunrise: Date(timeIntervalSince1970: TimeInterval(sys.sunrise)),
            sunset: Date(timeIntervalSince1970: TimeInterval(sys.sunset))
        )
    }
}
