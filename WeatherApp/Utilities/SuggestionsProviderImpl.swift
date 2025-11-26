//
//  SuggestionsProviderImpl.swift
//  WeatherApp
//
//  Created by maomar on 23/11/25.
//

import MapKit

class SuggestionsProviderImpl: NSObject {
    let completer = MKLocalSearchCompleter()
    weak var delegate: SuggestionsProviderDelegate?
    override init () {
        super.init()
        completer.resultTypes = .address
        completer.addressFilter = MKAddressFilter(including: .locality)
        completer.delegate = self
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

protocol SuggestionsProviderDelegate: AnyObject {
    func onSuggestionsReceived(result: [String])
    func onError(error: Error)
}
