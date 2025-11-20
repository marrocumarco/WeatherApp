//
//  AppPage.swift
//  WeatherApp
//
//  Created by maomar on 19/11/25.
//

import Foundation

enum AppPage: Hashable {
    case weatherList
    case weatherDetail(WeatherUI)
}
