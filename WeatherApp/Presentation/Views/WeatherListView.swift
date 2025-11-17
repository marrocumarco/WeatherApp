//
//  WeatherListView.swift
//  WeatherApp
//
//  Created by maomar on 17/11/25.
//

import SwiftUI

struct WeatherListView: View {
    @State var viewModel: WeatherListViewModel
    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(viewModel.weathersList) { weather in
                VStack {
                    Text(weather.locationName)
                    Text("\(weather.temperature)")
                }
            }.listStyle(.plain)
            .navigationTitle("Weather App")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.onSearchCompleted(cityName: searchText)
            }
        }
    }
}
