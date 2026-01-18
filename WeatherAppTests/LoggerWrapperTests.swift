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

        func info(message: String) {
            errorMessage = message
            infoCalled = true
        }

        func debug(message: String) {
            errorMessage = message
            debugCalled = true
        }

        func fault(message: String) {
            errorMessage = message
            faultCalled = true
        }
    }

    @Test func `logger initialization`() async throws {
        let logEngine: LogEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine
    }

    @Test func `write error log`() async throws {
        let logEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine

        LoggerWrapper.error(message: "test", category: .network)

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.category == .network)
        #expect(logEngine.errorCalled)

    }

    @Test func `write info log`() async throws {
        let logEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine

        LoggerWrapper.info(message: "test")

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.infoCalled)
    }

    @Test func `write debug log`() async throws {
        let logEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine

        LoggerWrapper.debug(message: "test")

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.debugCalled)
    }

    @Test func `write fault log`() async throws {
        let logEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine

        LoggerWrapper.fault(message: "test")

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.faultCalled)
    }
}
