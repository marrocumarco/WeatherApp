//
//  SuggestionsProviderDelegateMock.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

@testable import WeatherApp

class SuggestionsProviderDelegateMock: SuggestionsProviderDelegate {
    var resultsFound = false
    var error: Error?
    func onSuggestionsReceived(result: [String]) {
        resultsFound = true
    }
    
    func onError(error: any Error) {
        self.error = error
    }
}
