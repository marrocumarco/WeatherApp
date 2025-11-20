//
//  GeocoderImpl.swift
//  WeatherApp
//
//  Created by maomar on 19/11/25.
//

import MapKit

struct GeocoderImpl: Geocoder {
    func getCoordinatesFrom(_ address: String) async throws -> Coordinates {
        if let request = MKGeocodingRequest(addressString: address) {
            do {
                let mapitems = try await request.mapItems
                if let mapitem = mapitems.first {
                    return Coordinates(latitude: mapitem.location.coordinate.latitude, longitude: mapitem.location.coordinate.longitude)
                }
            } catch {
                throw GeocoderImplError.cordinatesNotFound
            }
        }
        throw GeocoderImplError.invalidAddress
    }
    
    enum GeocoderImplError: Error {
        case invalidAddress
        case cordinatesNotFound
    }
}
