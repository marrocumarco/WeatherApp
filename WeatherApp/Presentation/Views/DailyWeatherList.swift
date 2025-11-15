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
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.forecast) { forecast in
                    DailyWeatherCell(time: forecast.time, temperature: forecast.temperature, iconName: forecast.iconName)
                }
            }
        }

    }
}

struct DailyWeatherCell: View {
    let time: String
    let temperature: String
    let iconName: String
    var body: some View {
        VStack {
            Text(time)
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
            Text(temperature)
        }.font(.system(.subheadline, weight: .regular))
            .padding(10)
    }
}

#Preview {
    DailyWeatherList(viewModel: WeatherViewModelMock())
}
