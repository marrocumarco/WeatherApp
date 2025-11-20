//
//  Coordinator.swift
//  WeatherApp
//
//  Created by maomar on 19/11/25.
//

import Foundation
import SwiftUI

@Observable
class Coordinator {
    var path = NavigationPath()
    let weatherUseCase = WeatherUseCaseImpl(
        weatherRepository: WeatherRepositoryImpl(
            apiClient: try! ApiClientImpl(),
            imageLoader: ImageLoaderImpl()
        ), geocoder: GeocoderImpl()
    )

    let locationProvider = LocationProviderImpl()

    func push(page: AppPage) {
        path.append(page)
    }

    @ViewBuilder
    func build(page: AppPage) -> some View {
        switch page {
        case .weatherList:
            WeatherListView(
                viewModel: WeatherListViewModelImpl(
                    weatherUseCase: weatherUseCase,
                    locationProvider: locationProvider
                )
            )
        case .weatherDetail(let weather):
            LocalWeatherView(viewModel: LocalWeatherViewModel(weather: weather, weatherUseCase: weatherUseCase, locationProvider: locationProvider))
        }
    }
}
