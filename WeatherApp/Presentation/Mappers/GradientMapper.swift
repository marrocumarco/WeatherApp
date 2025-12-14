//
//  GradientMapper.swift
//  WeatherApp
//
//  Created by marrocumarco on 14/12/2025.
//

import SwiftUI

struct GradientMapper {
    static func gradient(for weatherClass: WeatherClass) -> Gradient {
        switch weatherClass {
        case .bolt:
            return Gradient(colors: [
                .indigo,
                .black.opacity(0.85)
            ])
        case .drizzle:
            return Gradient(colors: [
                .gray.opacity(0.5),
                .blue.opacity(0.4)
            ])
        case .sunRain:
            return Gradient(colors: [
                .cyan,
                .indigo
            ])
        case .snow:
            return Gradient(colors: [
                .white,
                .cyan.opacity(0.6)
            ])
        case .rain:
            return Gradient(colors: [
                .blue.opacity(0.8),
                .indigo
            ])
        case .fog:
            return Gradient(colors: [
                .gray.opacity(0.7),
                .gray.opacity(0.3)
            ])
        case .sun:
            return Gradient(colors: [
                .yellow,
                .orange
            ])
        case .cloudSun:
            return Gradient(colors: [
                .blue,
                .orange.opacity(0.5)
            ])
        case .cloud:
            return Gradient(colors: [
                .gray,
                .blue.opacity(0.2)
            ])
        }
    }
}
