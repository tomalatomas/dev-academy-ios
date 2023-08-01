//
// Filename: PlaceDetail.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI
import MapKit


struct PlaceDetail: View {
    var feature: Feature
    @Binding var favorites: [Feature]
    @State private var mapRegion: MKCoordinateRegion
    private let markers: [PlaceMarker]
    
    init(feature: Feature, favorites: Binding<[Feature]>) {
        self.feature = feature
        self._favorites = favorites
        self._mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        self.markers = [PlaceMarker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude), tint: .red))]
    }


    var body: some View {
        VStack(){
            AsyncImage(
                url: feature.properties.obrId1,
                content: { image in
                    image
                        .resizable()
                        .frame(maxHeight: 200)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(13)
                        .shadow(radius: 5)

                },
                placeholder: {
                    ProgressView()

                }
            )
            Text(feature.properties.druh.rawValue)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .font(.body)
            Map(coordinateRegion: $mapRegion, annotationItems: markers){_ in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude))
            }
                .cornerRadius(13)
        }
        .padding(13)
        .navigationTitle(feature.properties.nazev)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    if favorites.contains(feature) {
                        favorites.removeAll(where: {$0.properties.ogcFid == feature.properties.ogcFid})
                    } else {
                        favorites.append(feature)
                    }
                } label: {
                    Image(systemName: favorites.contains(feature) ? "heart.fill" : "heart")
                }
            }
        }
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        //PlaceDetail(feature: .constant(Features.mock.features.first!))
        PlaceDetail(feature: Features.mock.features.first!, favorites: .constant([]))
    }
}
