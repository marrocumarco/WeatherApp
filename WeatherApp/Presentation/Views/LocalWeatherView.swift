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
            HStack {
                Spacer()
                TemperatureAndLocationView(viewModel: viewModel)
            }
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct TemperatureAndLocationView: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.temperature)
                    .font(.system(size: 45, weight: .semibold))
                VStack {
                    Text("\(viewModel.minimumTemperature)")
                    Text("\(viewModel.maximumTemperature)")
                }
            }.padding()
            Label("Rome", systemImage: "location")
        }
    }
}

#Preview {
    LocalWeatherView(viewModel: WeatherViewModelMock())
}
