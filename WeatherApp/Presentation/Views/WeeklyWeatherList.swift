//
//  WeeklyWeatherList.swift
//  WeatherApp
//
//  Created by maomar on 14/11/25.
//

import SwiftUI

struct WeeklyWeatherList: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        LazyVStack {
            WeeklyWeatherCell(viewModel: viewModel)
            WeeklyWeatherCell(viewModel: viewModel)
            WeeklyWeatherCell(viewModel: viewModel)
            WeeklyWeatherCell(viewModel: viewModel)
            WeeklyWeatherCell(viewModel: viewModel)
            WeeklyWeatherCell(viewModel: viewModel)
            WeeklyWeatherCell(viewModel: viewModel)
        }
    }
}

struct WeeklyWeatherCell: View {
    @State var viewModel: WeatherViewModel
    var body: some View {
        HStack {
            Text("18:00").font(.system(size: 8, weight: .regular))
            Spacer()
            Image(systemName: "sun.max")
                .resizable()
                .frame(width: 18, height: 18)
            Text("\(viewModel.maximumTemperature)")
                .font(.system(size: 10, weight: .regular))
            Text("\(viewModel.maximumTemperature)")
                .font(.system(size: 10, weight: .regular))
        }.padding(.horizontal)
    }
}
