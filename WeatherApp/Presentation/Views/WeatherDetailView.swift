//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by maomar on 21/11/25.
//

import SwiftUI

struct WeatherDetailView: View {
    
    var weather: WeatherUI
    var ns: Namespace.ID
    
    var body: some View {
        VStack {
            Text("My Location".uppercased())
                .font(.system(size: 13, weight: .bold))
                .drawingGroup()
                .matchedGeometryEffect(id: "position-\(weather.id)", in: ns)
            Text(weather.locationName)
                .font(.system(size: 30))
                .foregroundStyle(.primary)
                .matchedGeometryEffect(id: "locationName-\(weather.id)", in: ns)
            Text(weather.temperature)
                .font(.system(size: 80, weight: .light))
                .matchedGeometryEffect(id: "temperature-\(weather.id)", in: ns)
            Text("\(weather.weatherDetails)")
                .foregroundStyle(.secondary)
                .matchedGeometryEffect(id: "weatherDetails-\(weather.id)", in: ns)
            HStack {
                Text("\(weather.minimumTemperature)")
                    .matchedGeometryEffect(id: "minimumTemperature-\(weather.id)", in: ns)
                Text("\(weather.maximumTemperature)")
                    .matchedGeometryEffect(id: "maximumTemperature-\(weather.id)", in: ns)
            }.font(.system(size: 12, weight: .medium))
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .matchedGeometryEffect(id: "frame-\(weather.id)", in: ns)
            .cornerRadius(12)
            .animation(.easeInOut, value: true)
    }
}


struct DailyCardView: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        VStack {
            Text(viewModel.weather?.weatherDetails ?? "")
            VStack(spacing: 40) {
                DailyWeatherList(viewModel: viewModel)
            }
        }
        .padding(.vertical)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}
