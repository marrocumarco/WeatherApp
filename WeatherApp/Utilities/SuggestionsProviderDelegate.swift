//
//  SuggestionsProviderDelegate.swift
//  WeatherApp
//
//  Created by marrocumarco on 20/12/2025.
//

protocol SuggestionsProviderDelegate: AnyObject {
    func onSuggestionsReceived(result: [String])
    func onError(error: Error)
}
