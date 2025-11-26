//
//  SuggestionsProvider.swift
//  WeatherAppTests
//
//  Created by maomar on 26/11/25.
//

import Testing
@testable import WeatherApp

class SuggestionsProviderDelegateMock: SuggestionsProviderDelegate {
    var results: [String]?
    func onSuggestionsReceived(result: [String]) {
        results = result
    }
    
    func onError(error: any Error) {
        print(error)
    }
}

@MainActor
struct SuggestionsProviderTest {

    let suggestionsProvider = SuggestionsProvider()
    let delegate = SuggestionsProviderDelegateMock()
    
    @Test func getSuggestions() async throws {
        suggestionsProvider.delegate = delegate
        
        suggestionsProvider.getSuggestions(searchString: "Roma")
        
        #expect(delegate.results != nil)
    }

}
