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

struct Log {

    private init() {}
    
    static var logEngine: LogEngine?

    static var assertionHandler: (String, StaticString, UInt) -> Void = { message, file, line in
        assertionFailure("\(#function) failed with error: \(message). File: \(file), Line: \(line)")
    }

    static func error(message: String, category: LogCategory) {
        checkConfiguration()
        logEngine?.error(message: message, category: category)
    }

    private static func checkConfiguration() {
        if logEngine == nil {
            assertionHandler("Attempted to log to LogEngine that hasn't been set.", #file, #line)
            return
        }
    }

    static func info(message: String, category: LogCategory) {
        checkConfiguration()
        logEngine?.info(message: message, category: category)
    }

    static func debug(message: String, category: LogCategory) {
        checkConfiguration()
        logEngine?.debug(message: message, category: category)
    }

    static func fault(message: String, category: LogCategory) {
        checkConfiguration()
        logEngine?.fault(message: message, category: category)
    }
}
