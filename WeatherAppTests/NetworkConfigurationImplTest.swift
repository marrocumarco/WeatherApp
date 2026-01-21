//
//  NetworkConfigurationImplTest.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 21/01/2026.
//

import Testing
@testable import WeatherApp

struct NetworkConfigurationImplTest {

    let sut: NetworkConfigurationImpl!

    init() {
        sut = try! NetworkConfigurationImpl()
    }

    @Test func `test api key initialization`() async throws {
        #expect(!sut.apiKey.isEmpty)
    }

}
