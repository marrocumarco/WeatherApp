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

    func info(message: String) {
        Logger(subsystem: subsystem, category: "").info("\(message)")
    }

    func debug(message: String) {
        Logger(subsystem: subsystem, category: "").debug("\(message)")
    }

    func fault(message: String) {
        Logger(subsystem: subsystem, category: "").fault("\(message)")
    }
}
