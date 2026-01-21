//
//  NetworkConfiguration.swift
//  WeatherApp
//
//  Created by marrocumarco on 21/01/2026.
//

import Foundation

protocol NetworkConfiguration {
    var apiBaseURL: URL { get }
    var apiKey: String { get }
}
