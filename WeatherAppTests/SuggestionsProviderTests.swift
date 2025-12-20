//
//  SuggestionsProviderTests.swift
//  WeatherAppTests
//
//  Created by maomar on 26/11/25.
//

import Testing
import MapKit
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

class SearchCompleterMock: SearchCompleter {
    var searchEndsWithError = false

    var resultTypes: MKLocalSearchCompleter.ResultType = []

    var addressFilter: MKAddressFilter?

    var delegate: (any MKLocalSearchCompleterDelegate)?

    var queryFragment: String = "" {
        didSet {
            if searchEndsWithError {
                delegate?.completer?(MKLocalSearchCompleter(), didFailWithError: SearchCompleterMockError.test)
            } else {
                delegate?.completerDidUpdateResults?(MKLocalSearchCompleter())
            }
        }
    }

    enum SearchCompleterMockError: Error {
        case test
    }
}

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
