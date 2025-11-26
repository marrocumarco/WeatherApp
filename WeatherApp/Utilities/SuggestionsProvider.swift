//
//  SuggestionsProvider.swift
//  WeatherApp
//
//  Created by maomar on 23/11/25.
//

import MapKit

class SuggestionsProvider: NSObject, MKLocalSearchCompleterDelegate {
    let completer = MKLocalSearchCompleter()
    weak var delegate: SuggestionsProviderDelegate?
    override init () {
        super.init()
        completer.delegate = self
    }
    
    func getSuggestions(searchString: String) {
        completer.queryFragment = searchString
    }
    
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

protocol SuggestionsProviderDelegate: AnyObject {
    func onSuggestionsReceived(result: [String])
    func onError(error: Error)
}
