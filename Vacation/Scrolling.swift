import SwiftUI

struct Scrolling: View {
    var body: some View {
        ScrollView {
            VStack {
                Scrollimage(image: "bellagio")
                Scrollimage(image: "excalibur")
                Scrollimage(image: "luxor")
                Scrollimage(image: "paris")
                Scrollimage(image: "startosphere")
                Scrollimage(image: "treasureisland")
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
}
