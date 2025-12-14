//
//  GradientMapper.swift
//  WeatherApp
//
//  Created by marrocumarco on 14/12/2025.
//

import SwiftUI

struct GradientMapper {
    // Backward compatibility: versione base solo per WeatherClass
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

    // Nuova API: calcolo day/night da date + sunrise/sunset e applico correzioni per colorScheme
    static func gradient(for weatherClass: WeatherClass, colorScheme: ColorScheme, date: Date, sunrise: Date, sunset: Date) -> Gradient {
        let isNight = date < sunrise || date > sunset
        return gradient(for: weatherClass, colorScheme: colorScheme, isNight: isNight)
    }

    // Overload utile se "notte" è già calcolato altrove
    static func gradient(for weatherClass: WeatherClass, colorScheme: ColorScheme, isNight: Bool) -> Gradient {
        if isNight {
            return nightPalette(for: weatherClass, colorScheme: colorScheme)
        } else {
            return dayPalette(for: weatherClass, colorScheme: colorScheme)
        }
    }

    private static func dayPalette(for weatherClass: WeatherClass, colorScheme: ColorScheme) -> Gradient {
        switch weatherClass {
        case .bolt:
            // di giorno: più blu in light, più indigo in dark
            return Gradient(colors: colorScheme == .dark ? [.indigo, .black.opacity(0.85)] : [.indigo, .blue.opacity(0.6)])
        case .drizzle:
            return Gradient(colors: colorScheme == .dark ? [.gray.opacity(0.6), .indigo.opacity(0.5)] : [.gray.opacity(0.5), .blue.opacity(0.4)])
        case .sunRain:
            return Gradient(colors: colorScheme == .dark ? [.cyan.opacity(0.7), .indigo] : [.cyan, .indigo])
        case .snow:
            return Gradient(colors: colorScheme == .dark ? [.cyan.opacity(0.8), .indigo.opacity(0.7)] : [.white, .cyan.opacity(0.6)])
        case .rain:
            return Gradient(colors: colorScheme == .dark ? [.indigo, .black.opacity(0.6)] : [.blue.opacity(0.8), .indigo])
        case .fog:
            return Gradient(colors: colorScheme == .dark ? [.gray.opacity(0.6), .black.opacity(0.5)] : [.gray.opacity(0.7), .gray.opacity(0.3)])
        case .sun:
            return Gradient(colors: colorScheme == .dark ? [.orange, .indigo.opacity(0.6)] : [.yellow, .orange])
        case .cloudSun:
            return Gradient(colors: colorScheme == .dark ? [.blue.opacity(0.6), .indigo.opacity(0.6)] : [.blue, .orange.opacity(0.5)])
        case .cloud:
            return Gradient(colors: colorScheme == .dark ? [.gray.opacity(0.7), .black.opacity(0.4)] : [.gray, .blue.opacity(0.2)])
        }
    }

    private static func nightPalette(for weatherClass: WeatherClass, colorScheme: ColorScheme) -> Gradient {
        // di notte: palette più scure; in dark mode spingiamo un po' di più sul nero
        switch weatherClass {
        case .bolt:
            return Gradient(colors: colorScheme == .dark ? [.black, .indigo] : [.indigo, .black.opacity(0.85)])
        case .drizzle:
            return Gradient(colors: colorScheme == .dark ? [.indigo.opacity(0.7), .black.opacity(0.7)] : [.gray.opacity(0.6), .indigo.opacity(0.6)])
        case .sunRain:
            return Gradient(colors: colorScheme == .dark ? [.indigo, .black] : [.indigo, .black.opacity(0.85)])
        case .snow:
            return Gradient(colors: colorScheme == .dark ? [.indigo.opacity(0.7), .black.opacity(0.7)] : [.cyan.opacity(0.8), .indigo.opacity(0.7)])
        case .rain:
            return Gradient(colors: colorScheme == .dark ? [.black, .indigo] : [.indigo, .black.opacity(0.85)])
        case .fog:
            return Gradient(colors: colorScheme == .dark ? [.gray.opacity(0.5), .black.opacity(0.7)] : [.gray.opacity(0.6), .black.opacity(0.6)])
        case .sun:
            return Gradient(colors: colorScheme == .dark ? [.black, .indigo.opacity(0.6)] : [.indigo, .black.opacity(0.85)])
        case .cloudSun:
            return Gradient(colors: colorScheme == .dark ? [.indigo.opacity(0.6), .black.opacity(0.6)] : [.indigo, .blue.opacity(0.3)])
        case .cloud:
            return Gradient(colors: colorScheme == .dark ? [.gray.opacity(0.6), .black.opacity(0.6)] : [.gray.opacity(0.7), .black.opacity(0.6)])
        }
    }
}

