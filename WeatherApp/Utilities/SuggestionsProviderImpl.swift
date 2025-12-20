//
//  SuggestionsProviderImpl.swift
//  WeatherApp
//
//  Created by maomar on 23/11/25.
//

import MapKit

class SuggestionsProviderImpl: NSObject {
    private(set) var completer: SearchCompleter
    weak var delegate: SuggestionsProviderDelegate?
    init(completer: SearchCompleter) {
        var newCompleter = completer
        newCompleter.resultTypes = .address
        newCompleter.addressFilter = MKAddressFilter(including: .locality)
        self.completer = newCompleter
        super.init()
        self.completer.delegate = self
    }
}

extension SuggestionsProviderImpl: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let resultStrings = completer.results.map {
            $0.title
        }
        delegate?.onSuggestionsReceived(result: resultStrings)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        delegate?.onError(error: error)
    }
}

extension SuggestionsProviderImpl: SuggestionsProvider {
    func getSuggestions(searchString: String) {
        completer.queryFragment = searchString
    }
}
