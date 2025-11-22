//
//  WeatherViewModelMock.swift
//  WeatherApp
//
//  Created by marrocumarco on 12/11/2025.
//

import Foundation

public class WeatherViewModelMock: WeatherViewModel {
    var weather: WeatherUI? = WeatherUI(
        isCurrentLocation: true,
        locationName: "Escovedum",
        time: "11:01",
        weatherDescription: "Basca",
        weatherDetails: "Baschixedda",
        temperature: "33°",
        minimumTemperature: "15°",
        maximumTemperature: "3°",
        iconName: "cloud"
    )

    var forecast: [ForecastUI] = [ForecastUI(time: "14", temperature: "23,5°", iconName: "sun"),
                                  ForecastUI(time: "15", temperature: "22,5°", iconName: "cloud"),
                                  ForecastUI(time: "16", temperature: "21,5°", iconName: "rain")]
}
