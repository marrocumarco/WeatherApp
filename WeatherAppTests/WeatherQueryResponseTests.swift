//
//  WeatherQueryResponseTests.swift
//  WeatherAppTests
//
//  Created by maomar on 02/10/25.
//

@testable import WeatherApp
import XCTest

@MainActor
final class WeatherQueryResponseTests: XCTestCase {

    var sut: WeatherQueryResponse! = nil

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_toWeather_success() throws {
        let main = MainInfoApi(temperature: 20, feelsLike: 18, minimumTemperature: 5, maximumTemperature: 27, pressure: 1800, humidity: 55)
        let sys = SystemInfoApi(country: "FR", sunrise: 1765869743, sunset: 1765905743)
        let weatherApi = WeatherApi(id: 511, main: "Sunny", description: "Description says sunny")
        sut = WeatherQueryResponse(name: "Paris", dt: 1765916286, timezone: 0, weather: [weatherApi], main: main, sys: sys)

        let weather = try sut.toWeather()

        let expectedWeather = Weather(id: 511, weatherClass: .snow, date: Date(timeIntervalSince1970: 1765916286), timezone: TimeZone(secondsFromGMT: 0)!, name: "Paris", mainDescription: "Sunny", detailedDescription: "Description says sunny", temperature: 20, minimumTemperature: 5, maximumTemperature: 27, pressure: 1800, humidity: 55, sunrise: Date(timeIntervalSince1970: 1765869743), sunset: Date(timeIntervalSince1970: 1765905743))

        XCTAssertEqual(weather, expectedWeather)
    }

    func test_toWeather_fail_emptyWeatherList() throws {
        let main = MainInfoApi(temperature: 20, feelsLike: 18, minimumTemperature: 5, maximumTemperature: 27, pressure: 1800, humidity: 55)
        let sys = SystemInfoApi(country: "FR", sunrise: 1765869743, sunset: 1765905743)
        sut = WeatherQueryResponse(name: "Paris", dt: 1765916286, timezone: 0, weather: [], main: main, sys: sys)

        XCTAssertThrowsError(try sut.toWeather())
    }

    func test_toWeather_fail_invalidTimezone() throws {
        let main = MainInfoApi(temperature: 20, feelsLike: 18, minimumTemperature: 5, maximumTemperature: 27, pressure: 1800, humidity: 55)
        let sys = SystemInfoApi(country: "FR", sunrise: 1765869743, sunset: 1765905743)
        let weatherApi = WeatherApi(id: 1, main: "Sunny", description: "Description says sunny")
        sut = WeatherQueryResponse(name: "Paris", dt: 1765916286, timezone: -123412, weather: [weatherApi], main: main, sys: sys)

        XCTAssertThrowsError(try sut.toWeather())
    }
}
