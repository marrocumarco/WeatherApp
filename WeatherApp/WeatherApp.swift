//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI
import MapKit

let locationProvider = LocationProviderImpl(locationManager: CLLocationManager())

@main
struct WeatherApp: App {
    
    init() {
        Log.logEngine = LogEngineImpl(subsystem: Bundle.main.bundleIdentifier!)
        Log.info(message: "WeatherApp is starting", category: .ui)
    }

    var body: some Scene {
        WindowGroup {
            if isRunningUnitTests() {
                Text("Running Unit Tests...")
            } else if let listView = try? buildMainView() {
                listView
            } else {
                Text("Error loading app...")
            }
        }
    }

    private func isRunningUnitTests() -> Bool {
        return NSClassFromString("XCTestCase") != nil
    }

    private func buildMainView() throws -> WeatherListView {
        guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
           let dict = NSDictionary(contentsOf: url) as? [String: Any] else {
            throw WeatherAppError.cannotLoadPlist
        }
        let viewModel = try DependencyInjectionContainer(configurationDictionary: dict).getWeatherListViewModel()
        return WeatherListView(
            viewModel: viewModel
        )
    }

    enum WeatherAppError: Error {
        case cannotLoadPlist
    }
}


