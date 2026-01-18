//
//  LoggerWrapper.swift
//  WeatherApp
//
//  Created by marrocumarco on 17/01/2026.
//

import Foundation

protocol LogEngine {
    func error(message: String, category: LogCategory)
    func info(message: String, category: LogCategory)
    func debug(message: String, category: LogCategory)
    func fault(message: String, category: LogCategory)
}

struct LoggerWrapper {

    private init() {}
    
    static var logEngine: LogEngine?

    static func error(message: String, category: LogCategory) {
        logEngine?.error(message: message, category: category)
    }

    static func info(message: String, category: LogCategory) {
        logEngine?.info(message: message, category: category)
    }

    static func debug(message: String, category: LogCategory) {
        logEngine?.debug(message: message, category: category)
    }

    static func fault(message: String, category: LogCategory) {
        logEngine?.fault(message: message, category: category)
    }
}
