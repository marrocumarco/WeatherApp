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

    @Test func `logger initialization`() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        _ = LoggerWrapper()
    }

}
