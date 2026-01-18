//
//  SearchCompleterMock.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

import MapKit
@testable import WeatherApp

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
