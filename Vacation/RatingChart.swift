import SwiftUI
import Charts

struct SampleRating {
    let place: String
    let rating: Int
    
    static let ratings: [SampleRating] = [
        SampleRating(place: "Bellagio", rating: 88),
        SampleRating(place: "Paris", rating: 75),
        SampleRating(place: "Treasure Island", rating: 33),
        SampleRating(place: "Excalibur", rating: 99),
    ]
}

struct RatingChart: View {
    var body: some View {
        Chart(SampleRating.ratings, id: \.place) { rating in
            SectorMark(
                angle: .value("Rating", rating.rating),
                innerRadius: .ratio(0.5),
                angularInset: 1
            )
                .cornerRadius(7)
                .foregroundStyle(by: .value("Place", rating.place))
        }
        .padding()
        .frame(height: 500)
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    RatingChart()
}
