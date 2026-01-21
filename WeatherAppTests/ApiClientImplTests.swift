//
//  ApiClientImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 20/12/2025.
//

import Testing
@testable import WeatherApp
import Foundation

struct MockNetworkConfiguration: NetworkConfiguration {
    let apiBaseURL: URL = URL(fileURLWithPath: "")
    let apiKey: String = ""
}

struct ApiClientImplTests {

    @Test func `create client`() async throws {

        let networkSessionMock = NetworkSessionMock(successCall: true, callType: .forecast)
        let _ = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())
    }

    @Test func `fetch forecast by coordinates success`() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: true, callType: .forecast)
        let client = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())

        let forecast = try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)

        #expect(!forecast.isEmpty)
    }

    @Test("throw error when the URL response is not OK", arguments: 400...417)
    func unsuccessfulNetworkCall(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, callType: .forecast)
        let client = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())

        let error = await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
        }

        switch error {
        case .requestError:
            break
        default:
            #expect(Bool(false), "Error should be ApiClientImplError.serverError")
        }
    }

    @Test("throws server error", arguments: 500...504)
    func unsuccessfulNetworkCall_serverError(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode, callType: .forecast)
        let client = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())


        let error = await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
        }

        switch error {
        case .serverError:
            break
        default:
            #expect(Bool(false), "Error should be ApiClientImplError.serverError")
        }
    }

    @Test func `fetch weather by coordinates success`() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: true, callType: .weather)
        let client = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())

        let _ = try await client.fetchWeatherBy(Coordinates(latitude: 35.0, longitude: 139.0))
    }

    @Test("throw error when the URL response is not OK", arguments: 400...417)
    func weather_unsuccessfulNetworkCall(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode, callType: .weather)
        let client = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())

        let error = await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
            try await client.fetchWeatherBy(Coordinates(latitude: 35.0, longitude: 139.0))
        }

        switch error {
        case .requestError:
            break
        default:
            #expect(Bool(false), "Error should be ApiClientImplError.serverError")
        }
    }

    @Test("throws server error", arguments: 500...504)
    func weather_unsuccessfulNetworkCall_serverError(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode, callType: .weather)
        let client = try await ApiClientImpl(networkSession: networkSessionMock, networkConfiguration: MockNetworkConfiguration())


        let error = await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
        }

        switch error {
        case .serverError:
            break
        default:
            #expect(Bool(false), "Error should be ApiClientImplError.serverError")
        }
    }
}
