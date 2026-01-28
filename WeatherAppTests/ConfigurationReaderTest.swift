//
//  ConfigurationReaderTest.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 21/01/2026.
//
import Foundation
import Testing
@testable import WeatherApp

@MainActor
struct ConfigurationReaderTest {

    let sut: ConfigurationReaderImpl!

    init() {
        sut = ConfigurationReaderImpl()
    }

    @Test func `test read network configuration`() async throws {
        let configuration: NetworkConfiguration = try sut.readNetworkConfiguration(from: ["API_KEY":"testApiKey1", "API_BASE_URL":"testApiUrl1"])

        #expect(configuration.apiKey == "testApiKey1")
        #expect(configuration.apiBaseURL == URL(string: "testApiUrl1"))
    }

    @Test func `test read network configuration throws error with empty dictionary`() async throws {
        let error = #expect(throws: ConfigurationReaderImpl.ConfigurationReaderImplError.self) {
            try sut.readNetworkConfiguration(from: [:])
        }

        #expect(error == .emptyConfigurationDictionary)
    }

    @Test func `test read network configuration throws error with invalid dictionary`() async throws {
        let error = #expect(throws: ConfigurationReaderImpl.ConfigurationReaderImplError.self) {
            try sut.readNetworkConfiguration(from: ["INVALID_KEY":"testApiKey1", "API_BASE_URL":"testApiUrl1"])
        }

        #expect(error == .invalidConfigurationDictionary)
    }

}
