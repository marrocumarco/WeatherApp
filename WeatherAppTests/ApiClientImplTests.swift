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
    internal init(successCall: Bool, responseStatusCode: Int? = nil, callType: CallType) {
        self.successCall = successCall
        if let responseStatusCode {
            self.responseStatusCode = responseStatusCode
        } else {
            self.responseStatusCode = successCall ? 200 : 400
        }
        self.callType = callType
    }
    
    let successCall: Bool
    let responseStatusCode: Int
    let callType: CallType


    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if successCall {
            return try executeSuccessCall()
        } else {
            return (Data(), HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=35.0&lon=139")!, statusCode: responseStatusCode, httpVersion: nil, headerFields: nil)!)
        }
    }

    private func executeSuccessCall() throws -> (Data, URLResponse) {
        switch callType {
        case .forecast:
            let url = Bundle(for: Self.self).url(forResource: "forecast_success_response", withExtension: "json")!
            let data = try Data(contentsOf: url)
            return (data, HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=35.0&lon=139")!, statusCode: responseStatusCode, httpVersion: nil, headerFields: nil)!)
        case .weather:
            let url = Bundle(for: Self.self).url(forResource: "weather_success_response", withExtension: "json")!
            let data = try Data(contentsOf: url)
            return (data, HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=35.0&lon=139")!, statusCode: responseStatusCode, httpVersion: nil, headerFields: nil)!)
        }
    }

    enum CallType {
        case forecast
        case weather
    }
}

struct ApiClientImplTests {

    @Test func `create client`() async throws {

        let networkSessionMock = NetworkSessionMock(successCall: true, callType: .forecast)
        let _ = try await ApiClientImpl(networkSession: networkSessionMock)
    }

    @Test func `fetch forecast by coordinates success`() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: true, callType: .forecast)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

        let forecast = try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)

        #expect(!forecast.isEmpty)
    }

    @Test("throw error when the URL response is not OK", arguments: 400...417)
    func unsuccessfulNetworkCall(responseStatusCode: Int) async throws {
        let networkSessionMock = NetworkSessionMock(successCall: false, callType: .forecast)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

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

    @Test func `fetch weather by coordinates success`() async throws {
        let networkSessionMock = NetworkSessionMock(successCall: true, callType: .weather)
        let client = try await ApiClientImpl(networkSession: networkSessionMock)

        let _ = try await client.fetchWeatherBy(Coordinates(latitude: 35.0, longitude: 139.0))
    }

//    @Test("throw error when the URL response is not OK", arguments: 400...417)
//    func unsuccessfulNetworkCall(responseStatusCode: Int) async throws {
//        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode)
//        let client = try await ApiClientImpl(networkSession: networkSessionMock)
//
//        let error = await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
//            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
//        }
//
//        switch error {
//        case .requestError:
//            break
//        default:
//            #expect(Bool(false), "Error should be ApiClientImplError.serverError")
//        }
//    }
//
//    @Test("throws server error", arguments: 500...504)
//    func unsuccessfulNetworkCall_serverError(responseStatusCode: Int) async throws {
//        let networkSessionMock = NetworkSessionMock(successCall: false, responseStatusCode: responseStatusCode)
//        let client = try await ApiClientImpl(networkSession: networkSessionMock)
//
//
//        let error = await #expect(throws: ApiClientImpl.ApiClientImplError.self) {
//            try await client.fetchForecastBy(Coordinates(latitude: 35.0, longitude: 139.0), numberOfForecasts: 1)
//        }
//
//        switch error {
//        case .serverError:
//            break
//        default:
//            #expect(Bool(false), "Error should be ApiClientImplError.serverError")
//        }
//    }
}
