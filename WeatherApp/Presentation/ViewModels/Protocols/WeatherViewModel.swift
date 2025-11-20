//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol WeatherViewModel: AnyObject {
    var forecast: [ForecastUI] { get }
    var weather: WeatherUI? { get }
}
