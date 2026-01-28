//
//  DependencyInjectionContainerTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 21/01/2026.
//
@testable import WeatherApp
import Testing

@MainActor
struct DependencyInjectionContainerTests {

    var sut: DependencyInjectionContainer!
    
    init() {
        sut = try? DependencyInjectionContainer(configurationDictionary: ["API_KEY":"testApiKey1", "API_BASE_URL":"testApiUrl1"] )
    }

    @Test func `returns WeatherListViewModel`() async throws {
        let _: WeatherListViewModel = sut.getWeatherListViewModel()
    }

}
