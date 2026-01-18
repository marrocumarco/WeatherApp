//
//  LoggerWrapper.swift
//  WeatherApp
//
//  Created by marrocumarco on 17/01/2026.
//

import Foundation

protocol LogEngine {
    func error(message: String, category: LogCategory)
    func info(message: String)
    func debug(message: String)
    func fault(message: String)
}

struct LoggerWrapper {

    private init() {}
    
    static var logEngine: LogEngine?

    static func error(message: String, category: LogCategory) {
        logEngine?.error(message: message, category: category)
    }

    static func info(message: String) {
        logEngine?.info(message: message)
    }

    static func debug(message: String) {
        logEngine?.debug(message: message)
    }

    static func fault(message: String) {
        logEngine?.fault(message: message)
    }
}
