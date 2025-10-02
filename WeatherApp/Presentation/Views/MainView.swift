//
//  MainView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("Local Weather", systemImage: "location") {
                LocalWeatherView(
                    viewModel: LocalWeatherViewModel(
                        weatherUseCase: WeatherUseCaseImpl(
                            locationProvider: LocationProviderImpl(),
                            weatherRepository: WeatherRepositoryImpl(apiClient: ApiClientImpl(), imageLoader: ImageLoaderImpl())
                        )
                    )
                )
            }

            Tab("Search location", systemImage: "magnifyingglass") {
                NavigationStack {
                    LocalWeatherView(
                        viewModel: SearchWeatherViewModel(
                            weatherUseCase: WeatherUseCaseImpl(
                                locationProvider: LocationProviderImpl(),
                                weatherRepository: WeatherRepositoryImpl(apiClient: ApiClientImpl(), imageLoader: ImageLoaderImpl())
                            )
                        )
                    )
                }
            }
        }
    }
}
