//
//  CoordinatorView.swift
//  WeatherApp
//
//  Created by maomar on 19/11/25.
//


import SwiftUI

struct CoordinatorView: View {
    @State private(set) var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .weatherList)
                .navigationDestination(for: AppPage.self) { page in
                    coordinator.build(page: page)
                }
        }.environment(coordinator)
    }
}
