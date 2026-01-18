//
//  LocalDataSourceImplTests.swift
//  WeatherAppTests
//
//  Created by marrocumarco on 18/01/2026.
//

import Foundation
import Testing
@testable import WeatherApp

@MainActor
class LocalDataSourceImplTests {
    var userDefaults: UserDefaults!
    var sut: LocalDataSourceImpl
    let suiteName = "test_localDataSource"

    init() {
        userDefaults = UserDefaults(suiteName: suiteName)

        userDefaults.removePersistentDomain(forName: suiteName)

        sut = LocalDataSourceImpl(userDefaults: userDefaults)

    }

    deinit {
        userDefaults.removePersistentDomain(forName: suiteName)
    }

    @Test func `test if saved data persists`() async throws {
        let testLocations = ["New York", "London", "Tokyo"]
        
        try sut.save(locations: testLocations)
        
        let savedLocations = sut.getLocations()
        
        #expect(savedLocations == testLocations)
    }

    @Test func `test save ampty array`() async throws {
        let testLocations: [String] = []

        try sut.save(locations: testLocations)

        let savedLocations = sut.getLocations()

        #expect(savedLocations.isEmpty)
    }

}
