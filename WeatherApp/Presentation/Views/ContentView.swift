//
//  ContentView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: LocalWeatherViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            viewModel.fetchWeather()
        }
    }
}

//#Preview {
//    ContentView(LocalWeatherViewModel())
//}
