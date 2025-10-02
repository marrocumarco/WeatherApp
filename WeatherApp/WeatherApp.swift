//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: LocalWeatherViewModel(weatherUseCase: WeatherUseCaseImpl(locationProvider: LocationProviderImpl(), weatherRepository: WeatherRepositoryImpl(apiClient: ApiClientImpl())))
            )
        }
    }
}
