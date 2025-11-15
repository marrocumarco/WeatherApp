//
//  ForecastQueryResponse.swift
//  WeatherApp
//
//  Created by maomar on 15/11/25.
//

import Foundation

struct ForecastQueryResponse: Decodable {
    let list: [ForecastApi]
    
    func toForecast() -> [Forecast] {
        list.map {
            Forecast(date: Date(timeIntervalSince1970: TimeInterval($0.dt)), iconId: $0.weather.first?.id ?? 0, temperature: $0.main.temp)
        }
    }
}
