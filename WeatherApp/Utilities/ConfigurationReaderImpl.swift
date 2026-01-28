//
//  ConfigurationReaderImpl.swift
//  WeatherApp
//
//  Created by marrocumarco on 21/01/2026.
//

import Foundation

struct ConfigurationReaderImpl {

    private let baseUrlKey = "API_BASE_URL"
    private let apiKeyKey = "API_KEY"

    func readNetworkConfiguration(from dictionary: [String: Any]) throws -> NetworkConfiguration {
        guard !dictionary.isEmpty else { throw ConfigurationReaderImplError.emptyConfigurationDictionary }

        if let urlString = dictionary[baseUrlKey] as? String,
           let url = URL(string: urlString),
           let apiKey = dictionary[apiKeyKey] as? String {
            return NetworkConfigurationImpl(apiBaseURL: url, apiKey: apiKey)
        }
        throw ConfigurationReaderImplError.invalidConfigurationDictionary
    }

    public enum ConfigurationReaderImplError: Error {
        case emptyConfigurationDictionary
        case invalidConfigurationDictionary
    }
}
