//
//  SuggestionsProviderTests.swift
//  WeatherAppTests
//
//  Created by maomar on 26/11/25.
//

import Testing
import MapKit
@testable import WeatherApp



@MainActor
struct SuggestionsProviderTests {

    let delegate = SuggestionsProviderDelegateMock()
    
    @Test func getSuggestions() async throws {
        let completer = SearchCompleterMock()

        let suggestionsProvider = SuggestionsProviderImpl(completer: completer)

        suggestionsProvider.delegate = delegate
        
        suggestionsProvider.getSuggestions(searchString: "Roma")

        #expect(completer.queryFragment == "Roma")
        #expect(delegate.resultsFound)
    }

    @Test func `getSuggestions throws error`() async throws {
        let completer = SearchCompleterMock()
        completer.searchEndsWithError = true
        let suggestionsProvider = SuggestionsProviderImpl(completer: completer)

        suggestionsProvider.delegate = delegate

        suggestionsProvider.getSuggestions(searchString: "Roma")

        #expect(completer.queryFragment == "Roma")
        #expect(!delegate.resultsFound)
        #expect(delegate.error != nil)
    }
}
