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
                Text(weather.locationName)
                    .font(.system(size: 30))
                    .foregroundStyle(.primary)
                Text(weather.temperature)
                    .font(.system(size: 80, weight: .light))
                Text("\(weather.weatherDetails)")
                    .foregroundStyle(.secondary)
                HStack {
                    Text("\(weather.minimumTemperature)")
                    Text("\(weather.maximumTemperature)")
                }.font(.system(size: 12, weight: .medium))
            }
            DailyCardView(forecastList: forecastList)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .matchedGeometryEffect(id: "frame-\(weather.id)", in: ns)
        .cornerRadius(12)
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
                iconName: "cloud.rain",
                gradientColors: Gradient(stops: [])
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
