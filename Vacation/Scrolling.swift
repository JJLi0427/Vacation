import SwiftUI
import SwiftData

struct Scrolling: View {
    @Query(sort: \Place.name) private var places: [Place]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(places) { place in
                    Scrollimage(show: place.image)
                }
            }
            .padding()
        }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    Scrolling()
        .modelContainer(Place.preview)
}
