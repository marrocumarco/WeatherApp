//
//  NetworkSessionMock.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

import Foundation
@testable import WeatherApp

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
