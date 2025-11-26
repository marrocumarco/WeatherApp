//
//  SuggestionsProvider.swift
//  WeatherApp
//
//  Created by marrocumarco on 26/11/2025.
//

import Foundation

protocol SuggestionsProvider {
    func getSuggestions(searchString: String)
    var delegate: SuggestionsProviderDelegate? { get set }
}
