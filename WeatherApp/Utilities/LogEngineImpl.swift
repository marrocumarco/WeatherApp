//
//  LogEngineImpl.swift
//  WeatherApp
//
//  Created by marrocumarco on 18/01/2026.
//

import OSLog

struct LogEngineImpl: LogEngine {
    internal init(subsystem: String) {
        self.subsystem = subsystem
    }
    
    let subsystem: String

    func error(message: String, category: LogCategory) {
        Logger(subsystem: subsystem, category: category.rawValue).error("\(message)")
    }

    func info(message: String, category: LogCategory) {
        Logger(subsystem: subsystem, category: category.rawValue).info("\(message)")
    }

    func debug(message: String, category: LogCategory) {
        Logger(subsystem: subsystem, category: category.rawValue).debug("\(message)")
    }

    func fault(message: String, category: LogCategory) {
        Logger(subsystem: subsystem, category: category.rawValue).fault("\(message)")
    }
}
