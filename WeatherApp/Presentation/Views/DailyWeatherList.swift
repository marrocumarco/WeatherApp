//
//  DailyWeatherList.swift
//  WeatherApp
//
//  Created by maomar on 14/11/25.
//

import SwiftUI

struct DailyWeatherList: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
                DailyWeatherCell(viewModel: viewModel)
            }
        }.scrollIndicators(.never)
    }
}

struct DailyWeatherCell: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        VStack {
            Text("18:00").font(.system(size: 8, weight: .regular))
            Image(systemName: "sun.max")
                .resizable()
                .frame(width: 18, height: 18)
            Text("\(viewModel.maximumTemperature)")
                .font(.system(size: 10, weight: .regular))
        }
    }
}
