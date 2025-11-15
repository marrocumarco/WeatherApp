//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct WeatherApi: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
