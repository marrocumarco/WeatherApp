//
//  ContentView.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import SwiftUI

struct LocalWeatherView: View {
    @State var viewModel: WeatherViewModel
    @State var offset: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    var ns: Namespace.ID
    
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
            //.scrollBounceBehavior(.basedOnSize)
        }.offset(CGSize(width: 0, height: offset))
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation.height
                    }.onEnded { value in
                        if value.translation.height > 100 {
                            dismiss()
                        } else {
                            withAnimation {
                                offset = 0
                            }
                        }
                    }
            ).matchedGeometryEffect(id: "frame-\(viewModel.weather?.id ?? "")", in: ns, isSource: true)
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
                    Text(viewModel.weather?.minimumTemperature ?? " ")
                        .animation(.default, value: viewModel.weather == nil)
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
    TemperatureAndLocationView(viewModel: WeatherViewModelMock())
}
