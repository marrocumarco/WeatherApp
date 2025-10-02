//
//  ImageLoader.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol ImageLoader {
    func fetchImageWith(_ code: String) async throws -> Data
}
