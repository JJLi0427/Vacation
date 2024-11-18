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
