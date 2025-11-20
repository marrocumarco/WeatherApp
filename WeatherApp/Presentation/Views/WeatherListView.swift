//
//  WeatherListView.swift
//  WeatherApp
//
//  Created by maomar on 17/11/25.
//

import SwiftUI

struct WeatherListView: View {
    @Environment(Coordinator.self) var coordinator
    @State var viewModel: WeatherListViewModel
    @State var searchText: String = ""

    var body: some View {
            List(viewModel.weathersList) { weather in
                WeatherListViewCell(weather: weather)
                    .onTapGesture {
                        coordinator.push(page: .weatherDetail(weather))
                    }
            }.listStyle(.plain)
                .contentShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 20)))
                .navigationTitle("Weather App")
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    viewModel.onSearchCompleted(cityName: searchText)
                }
        
    }
}

struct WeatherListViewCell: View {

    var weather: WeatherUI

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.locationName).font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.primary)
                Group {
                    Text("My Location")
                    Spacer()
                    Text("\(weather.weatherDetails)")
                }.foregroundStyle(.secondary)
            }
            .font(.system(size: 14, weight: .medium))
            Spacer()
            VStack(alignment: .trailing) {
                Text(weather.temperature).font(.system(size: 40, weight: .medium))
                Spacer()
                HStack {
                    Text("\(weather.minimumTemperature)")
                    Text("\(weather.maximumTemperature)")
                }.font(.system(size: 12, weight: .medium))
            }.foregroundStyle(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    WeatherListView(viewModel: WeatherListViewModelMock(), searchText: "")
}
