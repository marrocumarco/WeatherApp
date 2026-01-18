//
//  LoggerWrapperTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 17/01/2026.
//

import Testing
@testable import WeatherApp

@MainActor
@Suite(.serialized)
class LoggerWrapperTests {

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

    deinit {
        LoggerWrapper.logEngine = nil
    }

    @Test func `logger initialization`() async throws {
        let logEngine: LogEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine
    }

    @Test func `log error fails when logEngine is not set`() async throws {

        var assertionHandlerCalled = false
        let assertionHandler: (String, StaticString, UInt) -> Void = { _, _, _ in
            assertionHandlerCalled = true
        }
        LoggerWrapper.assertionHandler = assertionHandler
        LoggerWrapper.error(message: "test", category: .network)

        #expect(assertionHandlerCalled)
    }

    @Test func `log info fails when logEngine is not set`() async throws {

        var assertionHandlerCalled = false
        let assertionHandler: (String, StaticString, UInt) -> Void = { _, _, _ in
            assertionHandlerCalled = true
        }
        LoggerWrapper.assertionHandler = assertionHandler
        LoggerWrapper.info(message: "test", category: .network)

        #expect(assertionHandlerCalled)
    }

    @Test func `log debug fails when logEngine is not set`() async throws {

        var assertionHandlerCalled = false
        let assertionHandler: (String, StaticString, UInt) -> Void = { _, _, _ in
            assertionHandlerCalled = true
        }
        LoggerWrapper.assertionHandler = assertionHandler
        LoggerWrapper.debug(message: "test", category: .network)

        #expect(assertionHandlerCalled)
    }

    @Test func `log fault fails when logEngine is not set`() async throws {

        var assertionHandlerCalled = false
        let assertionHandler: (String, StaticString, UInt) -> Void = { _, _, _ in
            assertionHandlerCalled = true
        }
        LoggerWrapper.assertionHandler = assertionHandler
        LoggerWrapper.fault(message: "test", category: .network)

        #expect(assertionHandlerCalled)
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

        LoggerWrapper.info(message: "test", category: .network)

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.category == .network)
        #expect(logEngine.infoCalled)
    }

    @Test func `write debug log`() async throws {
        let logEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine

        LoggerWrapper.debug(message: "test", category: .network)

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.category == .network)
        #expect(logEngine.debugCalled)
    }

    @Test func `write fault log`() async throws {
        let logEngine = MockLogEngine()
        LoggerWrapper.logEngine = logEngine

        LoggerWrapper.fault(message: "test", category: .network)

        #expect(logEngine.errorMessage == "test")
        #expect(logEngine.category == .network)
        #expect(logEngine.faultCalled)
    }
}
