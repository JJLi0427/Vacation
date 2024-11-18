import SwiftUI
import SwiftData

struct Scrollimage: View {
    let show: Image
    
    var body: some View {
        show
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
            .scrollTransition { 
                content, 
                phase in
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.5)
                    .opacity(phase.isIdentity ? 1 : 0.5)
            }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    Scrollimage(show: Place.previewPlaces[0].image)
}
