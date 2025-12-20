//
//  SearchCompleter.swift
//  WeatherApp
//
//  Created by marrocumarco on 20/12/2025.
//

import MapKit

protocol SearchCompleter {
    var resultTypes: MKLocalSearchCompleter.ResultType { get set }
    var addressFilter: MKAddressFilter? { get set }
    var delegate: (any MKLocalSearchCompleterDelegate)? { get set }
    var queryFragment: String { get set }
}
