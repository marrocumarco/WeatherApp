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
    internal init(successCall: Bool, responseStatusCode: Int? = nil) {
        self.successCall = successCall
        if let responseStatusCode {
            self.responseStatusCode = responseStatusCode
        } else {
            self.responseStatusCode = successCall ? 200 : 400
        }
    }
    
    let successCall: Bool
    let responseStatusCode: Int

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if successCall {
            let url = Bundle(for: Self.self).url(forResource: "forecast_success_response", withExtension: "json")!
            let data = try Data(contentsOf: url)
            return (data, HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=35.0&lon=139")!, statusCode: responseStatusCode, httpVersion: nil, headerFields: nil)!)
        } else {
            return (Data(), HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=35.0&lon=139")!, statusCode: responseStatusCode, httpVersion: nil, headerFields: nil)!)
        }
    }
}

struct ApiClientImplTests {

    @Test func `create client`() async throws {

        let networkSessionMock = NetworkSessionMock(successCall: true)
        let _ = try await ApiClientImpl(networkSession: networkSessionMock)
    }

    @Test("fetch forecast by coordinates success")
    func successfulNetworkCall() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: true)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

        let forecast = try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)

        #expect(!forecast.isEmpty)
    }

    @Test("throw error when the URL response is not OK", arguments: [401, 403, 404, 500, 503])
    func unsuccessfulNetworkCall(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

        await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
        }
    }

    @Test("throws server error", arguments: [500, 503])
    func unsuccessfulNetworkCall_serverError(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)


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
