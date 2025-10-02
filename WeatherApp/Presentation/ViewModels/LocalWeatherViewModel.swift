//
//  LocalWeatherViewModel.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

@Observable
final class LocalWeatherViewModel {
    internal init(weatherUseCase: any WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    let weatherUseCase: WeatherUseCase
    
    func fetchWeather() {
        Task {
            do {
                let weather = try await weatherUseCase.fetchWeatherFor("Rome")
                print(weather)
            } catch {
                print(error)
            }
        }
    }
}
