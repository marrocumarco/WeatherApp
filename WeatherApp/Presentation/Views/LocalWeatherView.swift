//
//  ContentView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct LocalWeatherView: View {
    @State var viewModel: WeatherViewModel
    @State var searchText: String = ""
    var body: some View {
        VStack {
            Text(viewModel.locationName)
            Text(viewModel.weatherDescription)
            Text(viewModel.temperature)
            Text(viewModel.weatherDetails)
            HStack {
                Text("\(viewModel.minimumTemperature)")
                Text("\(viewModel.maximumTemperature)")
            }
        }
        .navigationTitle("Weather App")
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            if viewModel.searchMode == .cityName {
                viewModel.fetchWeatherByCityName(searchText)
            }
        }
        .padding()
        .onAppear() {
            if viewModel.searchMode == .location {
                viewModel.fetchWeatherByLocation()
            }
        }
    }
}

//#Preview {
//    ContentView(LocalWeatherViewModel())
//}
