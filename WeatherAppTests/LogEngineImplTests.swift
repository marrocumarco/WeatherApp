//
//  LogEngineImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 18/01/2026.
//

import Testing
@testable import WeatherApp

@MainActor
struct LogEngineImplTests {

    @Test func `log engine implements LogEngine`() async throws {
        let logEngine = LogEngineImpl(subsystem: "test")
        #expect(logEngine is LogEngine)
    }
}
