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
    @Environment(\.dismissSearch) var dismissSearch
    @Namespace var ns
    @State var selectedWeather: WeatherUI?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.weathersList) { weather in
                        let isPresented = selectedWeather == weather
                        WeatherListViewCell(weather: weather, ns: ns, isSource: !isPresented)
                            .matchedGeometryEffect(id: "frame-\(weather.id)", in: ns, isSource: !isPresented)
                            .onTapGesture {
                                withAnimation {
                                    selectedWeather = weather
                                }
                            }
                            .opacity(isPresented ? 0 : 1)
                            .animation(.easeInOut, value: isPresented)
                    }
                }
            }.contentShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 20)))
                .navigationTitle("Weather App")
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    viewModel.onSearchCompleted(cityName: searchText)
                    dismissSearch()
                }
        }.overlay {
            if let selectedWeather {
                WeatherDetailView(weather: selectedWeather, ns: ns)
                    .onTapGesture {
                        withAnimation {
                            self.selectedWeather = nil
                        }
                    }
            }
        }
    }
}

struct WeatherListViewCell: View {

    var weather: WeatherUI
    var ns: Namespace.ID
    var isSource: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.locationName)
                    .font(.system(size: 20, weight: .bold))
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
