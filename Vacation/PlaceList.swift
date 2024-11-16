//
//  ContentView.swift
//  Vacation
//
//  Created by 李佳骏 on 2024/11/13.
//

import SwiftUI
import SwiftData

struct PlaceList: View {
    @Query(sort: \Place.name) private var places: [Place]
    
    @State private var showImages = false
    
    var body: some View {
        NavigationStack {
            List(places) { place in
                HStack {
                    place.image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 7))
                        .frame(width: 100, height: 100)
                    
                    Text(place.name)
                    
                    Spacer()
                    
                    if place.interested {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .padding(.trailing)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Show Images", systemImage: "photo") {
                        showImages.toggle()
                    }
                }
            }
            .sheet(isPresented: $showImages) {
                Scrolling()
            }
        }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    PlaceList()
        .modelContainer(Place.preview)
}
