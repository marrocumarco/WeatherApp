//
//  WeatherClassProviderTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 16/12/2025.
//

import Testing
@testable import WeatherApp

@Suite("WeatherClassProvider mapping")
struct WeatherClassProviderTests {

    @Test("200...299 -> .bolt")
    func boltRange() throws {
        for code in [200, 250, 299] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .bolt:
                #expect(true, "Code \(code) should map to .bolt")
            default:
                #expect(Bool(false), "Code \(code) should map to .bolt")
            }
        }
    }

    @Test("300...399 -> .drizzle")
    func drizzleRange() throws {
        for code in [300, 350, 399] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .drizzle:
                #expect(true, "Code \(code) should map to .drizzle")
            default:
                #expect(Bool(false), "Code \(code) should map to .drizzle")
            }
        }
    }

    @Test("500...504 -> .sunRain")
    func sunRainRange() throws {
        for code in [500, 502, 504] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .sunRain:
                #expect(true, "Code \(code) should map to .sunRain")
            default:
                #expect(Bool(false), "Code \(code) should map to .sunRain")
            }
        }
    }

    @Test("511 -> .snow")
    func snow511() throws {
        let result = try WeatherClassProvider.weatherClass(for: 511)
        switch result {
        case .snow:
            #expect(true, "Code 511 should map to .snow")
        default:
            #expect(Bool(false), "Code 511 should map to .snow")
        }
    }

    @Test("520...599 -> .rain")
    func rainRange() throws {
        for code in [520, 550, 599] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .rain:
                #expect(true, "Code \(code) should map to .rain")
            default:
                #expect(Bool(false), "Code \(code) should map to .rain")
            }
        }
    }

    @Test("600...699 -> .snow")
    func snowRange() throws {
        for code in [600, 650, 699] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .snow:
                #expect(true, "Code \(code) should map to .snow")
            default:
                #expect(Bool(false), "Code \(code) should map to .snow")
            }
        }
    }

    @Test("700...799 -> .fog")
    func fogRange() throws {
        for code in [700, 750, 799] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .fog:
                #expect(true, "Code \(code) should map to .fog")
            default:
                #expect(Bool(false), "Code \(code) should map to .fog")
            }
        }
    }

    @Test("800 -> .sun")
    func sun800() throws {
        let result = try WeatherClassProvider.weatherClass(for: 800)
        switch result {
        case .sun:
            #expect(true, "Code 800 should map to .sun")
        default:
            #expect(Bool(false), "Code 800 should map to .sun")
        }
    }

    @Test("801 -> .cloudSun")
    func cloudSun801() throws {
        let result = try WeatherClassProvider.weatherClass(for: 801)
        switch result {
        case .cloudSun:
            #expect(true, "Code 801 should map to .cloudSun")
        default:
            #expect(Bool(false), "Code 801 should map to .cloudSun")
        }
    }

    @Test("802...804 -> .cloud")
    func cloudRange() throws {
        for code in [802, 803, 804] {
            let result = try WeatherClassProvider.weatherClass(for: code)
            switch result {
            case .cloud:
                #expect(true, "Code \(code) should map to .cloud")
            default:
                #expect(Bool(false), "Code \(code) should map to .cloud")
            }
        }
    }

    @Test("Invalid codes throw .invalidCode")
    func invalidCodesThrow() {
        let invalidCodes = [-1, 0, 199, 400, 505, 510, 512, 519, 805, 900]
        for code in invalidCodes {
            let error = #expect(throws: WeatherClassProvider.WeatherClassProviderError.self) {
                try WeatherClassProvider.weatherClass(for: code)
            }
            #expect(error == .invalidCode)
        }
    }
}
