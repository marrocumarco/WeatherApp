//
//  NetworkSession.swift
//  WeatherApp
//
//  Created by marrocumarco on 21/01/2026.
//

import Foundation

protocol NetworkSession {
    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse)
}
