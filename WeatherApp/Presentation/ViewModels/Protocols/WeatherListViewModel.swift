//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by maomar on 18/11/25.
//

import Foundation

protocol WeatherListViewModel {
    var weathersList: [WeatherUI] { get set }
    var forecastList: [ForecastUI] { get }
    var weatherDetail: WeatherUI? { get }
    var locationSuggestions: [String]? { get set }
    func onSearchTextChanged(searchText: String)
    func onSearchCompleted(cityName: String)
    func onWeatherSelected(weather: WeatherUI)
    func viewDidAppear()
    func moveItems(from source: IndexSet, to destination: Int)
    func deleteItems(at offsets: IndexSet)
}
