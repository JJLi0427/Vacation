//
//  ContentView.swift
//  Vacation
//
//  Created by 李佳骏 on 2024/11/13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Places", systemImage: "photo") {
                PlaceList()
            }
            
            Tab("Add", systemImage: "plus.circle") {
                AddPlaceView()
            }
            
            Tab("Budget", systemImage: "wallet.bifold") {
                RatingChart()
            }
        }
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    ContentView()
        .modelContainer(Place.preview)
}
