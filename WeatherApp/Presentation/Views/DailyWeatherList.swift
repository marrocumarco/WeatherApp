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
                ForEach(viewModel.forecast) { forecast in
                    DailyWeatherCell(time: forecast.time, temperature: forecast.temperature)
                }
            }
        }.scrollIndicators(.never)
    }
}

struct DailyWeatherCell: View {
    let time: String
    let temperature: String
    var body: some View {
        VStack {
            Text(time).font(.system(size: 8, weight: .regular))
            Image(systemName: "sun.max")
                .resizable()
                .frame(width: 18, height: 18)
            Text(temperature)
                .font(.system(size: 10, weight: .regular))
        }
    }
}
