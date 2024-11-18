import SwiftUI
import PhotosUI
import SwiftData
import MapKit

struct AddPlaceView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var latitude: Double?
    @State private var longitude: Double?
    @State private var interested = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 0,
                longitude: 0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    )
    
    private var hasValidCoordinates: Bool {
        guard let lat = latitude, let lon = longitude else { return false }
        return lat >= -90 && lat <= 90 && lon >= -180 && lon <= 180
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Info") {
                    TextField("Name", text: $name)
                    TextField("Latitude", value: $latitude, format: .number)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", value: $longitude, format: .number)
                        .keyboardType(.decimalPad)
                    Toggle("Interest", isOn: $interested)
                }

                Section("Image") {
                    if let imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    PhotosPicker(selection: $selectedItem,
                               matching: .images) {
                        Label("Choose", systemImage: "photo.fill")
                    }
                }
                
                if hasValidCoordinates {
                    Section("Location") {
                        Map(position: $region)
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                
                Button("Save") {
                    let place = Place(
                        name: name,
                        latitude: latitude ?? 0.0,
                        longitude: longitude ?? 0.0,
                        interested: interested
                    )
                    place.imageData = imageData
                    modelContext.insert(place)
                    dismiss()
                }
                .disabled(name.isEmpty)
            }

            .navigationTitle("New Place")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {

                }
            }
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        imageData = data
                    }
                }
            }
            .onChange(of: latitude) {
                updateRegion()
            }
            .onChange(of: longitude) {
                updateRegion()
            }
        }
    }
    
    private func updateRegion() {
        guard hasValidCoordinates else { return }
        region = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: latitude ?? 0,
                    longitude: longitude ?? 0
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
        )
    }
}

private struct PreviewPlace: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

#Preview {
    AddPlaceView()
        .modelContainer(Place.preview)
} 
