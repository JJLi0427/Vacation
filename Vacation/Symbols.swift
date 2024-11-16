//
//  VacationApp.swift
//  Vacation
//
//  Created by 李佳骏 on 2024/11/13.
//

import SwiftUI

struct Symbols: View {
    @State private var bounceFlag = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .symbolEffect(.pulse)
            
            Image(systemName: "paperplane")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .symbolEffect(.pulse)
            
            Image(systemName: "person.crop.circle.badge.plus")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce, value: bounceFlag)
                .onTapGesture {
                    bounceFlag.toggle()
                }
            
            Text("Hello, world!")
        }
        .padding()
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    Symbols()
}
