//
//  SystemInfoApi.swift
//  WeatherApp
//
//  Created by marrocumarco on 14/12/2025.
//

import Foundation

struct SystemInfoApi: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}
