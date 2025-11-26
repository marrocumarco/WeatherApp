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
    @Namespace var ns
    @State var selectedWeather: WeatherUI?
    @State var offset: CGFloat = 0
    @State var isSearchFocused: Bool = false
    
    let animation = Animation.spring()
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach($viewModel.weathersList) { weather in
                        let isPresented = selectedWeather == weather.wrappedValue
                        WeatherListViewCell(weather: weather.wrappedValue, ns: ns, isSource: !isPresented)
                            .moveDisabled(weather.wrappedValue.isCurrentLocation)
                            .deleteDisabled(weather.wrappedValue.isCurrentLocation)
                            .matchedGeometryEffect(id: "frame-\(weather.id)", in: ns, isSource: !isPresented)
                            .onTapGesture {
                                viewModel.onWeatherSelected(weather: weather.wrappedValue)
                                withAnimation(animation) {
                                    selectedWeather = weather.wrappedValue
                                }
                            }
                        //                        .opacity(isPresented ? 0 : 1)
                        //                        .animation(.easeInOut, value: isPresented)
                    }.onMove { indices, newOffset in
                        viewModel.moveItems(from: indices, to: newOffset)
                    }.onDelete { index in
                        viewModel.deleteItems(at: index)
                    }
                }
                .listStyle(.plain)
                .contentShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 20)))
                .navigationTitle("Weather App")
                .searchable(text: $searchText, isPresented: $isSearchFocused, prompt: "Search the city")
                .searchSuggestions {
                    
                }
                .onSubmit(of: .search) {
                    viewModel.onSearchCompleted(cityName: searchText)
                    DispatchQueue.main.async {
                        searchText = ""
                        isSearchFocused = false
                    }
                }
            }
            if let selectedWeather {
                WeatherDetailView(weather: selectedWeather, forecastList: viewModel.forecastList, ns: ns)
                    .offset(y: offset)
                    .gesture(
                        DragGesture().onChanged { value in
                            offset = value.translation.height
                        }.onEnded { value in
                            if value.translation.height > 100 {
                                withAnimation(animation) {
                                    self.selectedWeather = nil
                                }
                                offset = 0
                            } else {
                                withAnimation(animation) {
                                    offset = 0
                                }
                            }
                        }
                    )
            }
        }.onAppear {
            viewModel.viewDidAppear()
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
                    Text(weather.time)
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
    WeatherListView(viewModel: WeatherListViewModelMock())
}
