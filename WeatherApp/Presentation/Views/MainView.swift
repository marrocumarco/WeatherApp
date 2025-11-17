//
//  MainView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        //        LocalWeatherView(
        //            viewModel: LocalWeatherViewModel(
        //                weatherUseCase: WeatherUseCaseImpl(
        //                    weatherRepository: WeatherRepositoryImpl(
        //                        apiClient: try! ApiClientImpl(),
        //                        imageLoader: ImageLoaderImpl()
        //                    )
        //                ), locationProvider: LocationProviderImpl()
        //            )
        //        ).ignoresSafeArea()
        WeatherListView(
            viewModel: WeatherListViewModel(
                weatherUseCase: WeatherUseCaseImpl(
                    weatherRepository: WeatherRepositoryImpl(
                        apiClient: try! ApiClientImpl(),
                        imageLoader: ImageLoaderImpl()
                    )
                ),
                locationProvider: LocationProviderImpl()
            )
        )
    }
}
