//
//  ContentView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct LocalWeatherView: View {
    @State var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            Image("background_sun")
                .resizable()
                .scaledToFill()
            ScrollView {
                VStack(spacing: 140) {
                    HStack {
                        Spacer()
                        TemperatureAndLocationView(viewModel: viewModel)
                    }
                    Spacer()
                    DailyCardView(viewModel: viewModel)
                }
                .padding(.top, 80)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct TemperatureAndLocationView: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.weather?.temperature ?? "")
                    .font(.system(size: 45, weight: .semibold))
                VStack {
                    Text(viewModel.weather?.minimumTemperature ?? "")
                    Text(viewModel.weather?.maximumTemperature ?? "")
                }
            }.padding()
            Label(viewModel.weather?.locationName ?? "", systemImage: "location")
        }
    }
}

struct DailyCardView: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        VStack {
            Text(viewModel.weather?.weatherDetails ?? "")
            VStack(spacing: 40) {
                DailyWeatherList(viewModel: viewModel)
            }
        }
        .padding(.vertical)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

#Preview {
    DailyCardView(viewModel: WeatherViewModelMock())
}
