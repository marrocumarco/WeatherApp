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
        sut = try? DependencyInjectionContainer()
    }

    @Test func `returns WeatherListViewModel`() async throws {
        let result: WeatherListViewModel = sut.getWeatherListViewModel()
    }

}
