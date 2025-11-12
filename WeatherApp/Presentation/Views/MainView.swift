//
//  MainView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        LocalWeatherView(
            viewModel: LocalWeatherViewModel(
                weatherUseCase: WeatherUseCaseImpl(
                    locationProvider: LocationProviderImpl(),
                    weatherRepository: WeatherRepositoryImpl(
                        apiClient: ApiClientImpl(),
                        imageLoader: ImageLoaderImpl()
                    )
                )
            )
        ).ignoresSafeArea()
    }
}
