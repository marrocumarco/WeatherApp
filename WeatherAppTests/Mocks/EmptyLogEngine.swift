//
//  EmptyLogEngine.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

@testable import WeatherApp

struct EmptyLogEngine: LogEngine {
    func error(message: String, category: LogCategory) {}
    
    func info(message: String, category: LogCategory) {}
    
    func debug(message: String, category: LogCategory) {}
    
    func fault(message: String, category: LogCategory) {}
}
