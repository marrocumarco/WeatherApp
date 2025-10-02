//
//  ImageLoaderImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct ImageLoaderImpl: ImageLoader {
    func fetchImageWith(_ code: String) async throws -> Data {
        let urlString = String(format: "https://openweathermap.org/img/wn/\(code)@2x.png")
        
        guard let url = URL(string: urlString) else { throw  ImageLoaderError.invalidURL }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return data
    }
}

enum ImageLoaderError: Error {
    case invalidURL
}
