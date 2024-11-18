import SwiftUI
import MapKit

struct MapView: View {
    var place: Place

    @State var position: MapCameraPosition

    var body: some View {
        Map(position: $position) {
            Annotation(
                place.interested ? "Place of Interest" : "Not Interest", 
                coordinate: place.location
            ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .stroke(.secondary, lineWidth: 3)
                    Image(systemName: place.interested ? "face.smiling" : "hand.thumbsdown")
                        .foregroundStyle(.yellow)
                        .padding(5)
                }
                .onTapGesture {
                    place.interested.toggle()
                }
            }
        }
        .toolbarBackground(.automatic)
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    @Previewable @State var place = Place.previewPlaces[0]

    MapView(
        place: place, 
        position: .camera(
            MapCamera(
                centerCoordinate: place.location, 
                distance: 1000, 
                heading: 250, 
                pitch: 80
            )
        )
    )
}
