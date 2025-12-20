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
}

extension WeatherQueryResponse {
    func toWeather() throws -> Weather {
        guard let weather = weather.first else {
            throw WeatherQueryResponseError.emptyWeatherList
        }

        guard let timezone = TimeZone(secondsFromGMT: timezone) else {
            throw WeatherQueryResponseError.invalidTimezone
        }

        return Weather(
            id: weather.id,
            weatherClass: try WeatherClassProvider.weatherClass(for: weather.id),
            date: Date(timeIntervalSince1970: TimeInterval(dt)),
            timezone: timezone,
            name: name,
            mainDescription: weather.main,
            detailedDescription: weather.description,
            temperature: main.temperature,
            minimumTemperature: main.minimumTemperature,
            maximumTemperature: main.maximumTemperature,
            pressure: main.pressure,
            humidity: main.humidity,
            sunrise: Date(timeIntervalSince1970: TimeInterval(sys.sunrise)),
            sunset: Date(timeIntervalSince1970: TimeInterval(sys.sunset))
        )
    }

    enum WeatherQueryResponseError: Error {
        case emptyWeatherList
        case invalidTimezone
    }
}
