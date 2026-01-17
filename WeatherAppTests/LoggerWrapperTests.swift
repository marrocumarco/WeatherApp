//
//  LoggerWrapperTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 17/01/2026.
//

import Testing
@testable import WeatherApp

@MainActor
struct LoggerWrapperTests {

    struct MockLogEngine: LogEngine {

    }

    @Test func `logger initialization`() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let logEngine: LogEngine = MockLogEngine()
        _ = LoggerWrapper(logEngine: logEngine)
    }

}
