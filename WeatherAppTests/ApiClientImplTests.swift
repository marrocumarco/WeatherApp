//
//  ApiClientImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 20/12/2025.
//

import Testing
@testable import WeatherApp
import Foundation


class NetworkSessionMock: NetworkSession {
    internal init(successCall: Bool) {
        self.successCall = successCall
    }
    
    let successCall: Bool
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if successCall {
            let url = Bundle(for: Self.self).url(forResource: "forecast_success_response", withExtension: "json")!
            let data = try Data(contentsOf: url)
            return (data, HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=35.0&lon=139")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
        } else {
            return (Data(), HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=35.0&lon=139")!, statusCode: 501, httpVersion: nil, headerFields: nil)!)
        }
    }
}

struct ApiClientImplTests {

    @Test func `create client`() async throws {

        let networkSessionMock = NetworkSessionMock(successCall: true)
        let _ = try await ApiClientImpl(networkSession: networkSessionMock)
    }

    @Test func `fetch forecast by coordinates success`() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: true)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

        let forecast = try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)

        #expect(!forecast.isEmpty)
    }

    @Test func `throw error when the URL response is not OK`() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

        await #expect(throws: Error.self) {
            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
        }
    }
}
