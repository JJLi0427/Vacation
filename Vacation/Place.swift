import SwiftData
import SwiftUI
import MapKit

@Model
class Place {
    #Unique<Place>([\.name, \.latitude, \.longitude])
    
    @Attribute(.unique) var name: String
    var latitude: Double
    var longitude: Double
    var interested: Bool
    var imageData: Data?
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var image: Image {
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        return Image(name.lowercased().replacingOccurrences(of: " ", with: ""))
    }
    
    init(name: String, latitude: Double, longitude: Double, interested: Bool) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.interested = interested
    }
    
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Place.self, 
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        for place in previewPlaces {
            container.mainContext.insert(place)
        }
        
        return container
    }
    
    static var previewPlaces: [Place] {
        [
            Place(
                name: "Bellagio", 
                latitude: 36.1129, 
                longitude: -115.1765, 
                interested: true
            ),
            Place(
                name: "Startosphere",
                latitude: 36.1475, 
                longitude: -115.1566, 
                interested: false
            ),            Place(
                name: "Excalibur", 
                latitude: 36.0988, 
                longitude: -115.1754, 
                interested: true
            )
        ]
    }
}
