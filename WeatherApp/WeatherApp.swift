//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI
let locationProvider = LocationProviderImpl()
@main
struct WeatherApp: App {
    
    let weatherUseCase = WeatherUseCaseImpl(
        weatherRepository: WeatherRepositoryImpl(
            apiClient: try! ApiClientImpl(),
            imageLoader: ImageLoaderImpl()
        ), geocoder: GeocoderImpl()
    )
    
    //let locationProvider = LocationProviderImpl()
    
    var body: some Scene {
        WindowGroup {
            WeatherListView(
                viewModel: WeatherListViewModelImpl(
                    weatherUseCase: weatherUseCase,
                    locationProvider: locationProvider
                )
            )
        }
    }
}


