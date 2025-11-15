//
//  WeatherQueryResponse.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct WeatherQueryResponse: Decodable {
    let id: Int
    let name: String
    let weather: [WeatherApi]
    let main: MainInfoApi
    
    func toWeather() -> Weather {
        Weather(
            id: id,
            name: name,
            mainDescription: weather.first?.main ?? "",
            detailedDescription: weather.first?.description ?? "",
            temperature: main.temperature,
            minimumTemperature: main.minimumTemperature,
            maximumTemperature: main.maximumTemperature,
            pressure: main.pressure,
            humidity: main.humidity,
            iconId: weather.first?.icon ?? ""
        )
    }
}


