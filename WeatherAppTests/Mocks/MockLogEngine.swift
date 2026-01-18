//
//  MockLogEngine.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

@testable import WeatherApp

class MockLogEngine: LogEngine {

    var errorMessage: String?
    var category: LogCategory?
    
    var errorCalled = false
    var infoCalled = false
    var debugCalled = false
    var faultCalled = false

    func error(message: String, category: LogCategory) {
        errorMessage = message
        self.category = category
        errorCalled = true
    }

    func info(message: String, category: LogCategory) {
        errorMessage = message
        self.category = category
        infoCalled = true
    }

    func debug(message: String, category: LogCategory) {
        errorMessage = message
        self.category = category
        debugCalled = true
    }

    func fault(message: String, category: LogCategory) {
        errorMessage = message
        self.category = category
        faultCalled = true
    }
}
