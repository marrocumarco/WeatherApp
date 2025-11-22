//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by maomar on 21/11/25.
//

import SwiftUI

struct WeatherDetailView: View {
    
    var weather: WeatherUI
    var forecastList: [ForecastUI]
    var ns: Namespace.ID
    
    var body: some View {
        VStack(spacing: 40) {
            VStack {
                Text(weather.time)
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
            }
            DailyCardView(forecastList: forecastList)
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
    var forecastList: [ForecastUI]
    var body: some View {
        DailyWeatherList(forecastList: forecastList)
        .padding(.vertical)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

#Preview {
    struct PreviewContainer: View {
        @Namespace var ns
        var body: some View {
            let sampleWeather = WeatherUI(
                isCurrentLocation: true,
                locationName: "Roma",
                time: "18:02",
                weatherDescription: "Pioggia",
                weatherDetails: "Pioggia a catinelle",
                temperature: "12°C",
                minimumTemperature: "5°C",
                maximumTemperature: "20°C",
                iconName: "cloud.rain"
            )
            let sampleForecast: [ForecastUI] = [
                ForecastUI(time: "14", temperature: "23.5°", iconName: "sun.max"),
                ForecastUI(time: "15", temperature: "22.5°", iconName: "cloud"),
                ForecastUI(time: "16", temperature: "21.5°", iconName: "cloud.rain")
            ]
            return WeatherDetailView(weather: sampleWeather, forecastList: sampleForecast, ns: ns)
                .padding()
        }
    }
    return PreviewContainer()
}
