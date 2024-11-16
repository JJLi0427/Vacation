//
//  ContentView.swift
//  Vacation
//
//  Created by 李佳骏 on 2024/11/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PlaceList()
        }
        .padding()
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    ContentView()
}
