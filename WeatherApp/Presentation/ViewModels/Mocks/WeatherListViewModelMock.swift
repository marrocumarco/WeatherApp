//
//  WeatherListViewModelMock.swift
//  WeatherApp
//
//  Created by maomar on 18/11/25.
//

import SwiftUI

struct WeatherListViewModelMock: WeatherListViewModel {
    var locationSuggestions: [String]?

    func onSearchTextChanged(searchText: String) {
        
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        
    }

    func deleteItems(at offsets: IndexSet) {
        
    }

  
    func viewDidAppear() {
        
    }

    var forecastList: [ForecastUI] = []


    var weatherDetail: WeatherUI?
    var weathersList: [WeatherUI] = [
        WeatherUI(
            isCurrentLocation: true,
            locationName: "Roma",
            time: "13:00",
            weatherDescription: "Pioggia",
            weatherDetails: "Pioggia a catinelle",
            temperature: "12°C",
            minimumTemperature: "5°C",
            maximumTemperature: "20°C",
            iconName: "rain",
            lightGradientColors: Gradient(stops: []),
            darkGradientColors: Gradient(stops: []),
            sunrise: "06:00",
            sunset: "18:00"
        ),
        WeatherUI(
            isCurrentLocation: false,
            locationName: "Roma",
            time: "01:32",
            weatherDescription: "Pioggia",
            weatherDetails: "Pioggia a catinelle",
            temperature: "12°C",
            minimumTemperature: "5°C",
            maximumTemperature: "20°C",
            iconName: "rain",
            lightGradientColors: Gradient(stops: []),
            darkGradientColors: Gradient(stops: []),
            sunrise: "06:00",
            sunset: "18:00"
        ),
        WeatherUI(
            isCurrentLocation: false,
            locationName: "Roma",
            time: "16:44",
            weatherDescription: "Pioggia",
            weatherDetails: "Pioggia a catinelle",
            temperature: "12°C",
            minimumTemperature: "5°C",
            maximumTemperature: "20°C",
            iconName: "rain",
            lightGradientColors: Gradient(stops: []),
            darkGradientColors: Gradient(stops: []),
            sunrise: "06:00",
            sunset: "18:00"
        )
]

    func onSearchCompleted(cityName: String) {
    }
    
    func onWeatherSelected(weather: WeatherUI) {}
}

