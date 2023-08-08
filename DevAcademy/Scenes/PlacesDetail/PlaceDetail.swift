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
    let feature: Feature
    @Binding var favorites: [Feature]
    @State private var mapRegion: MKCoordinateRegion
    @State private var showDetail: Bool
    private let markers: [PlaceMarker]

    init(feature: Feature, favorites: Binding<[Feature]>) {
        self.feature = feature
        self._favorites = favorites

        let location = CLLocationCoordinate2D(latitude: feature.geometry.latitude,
                                              longitude: feature.geometry.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        self._mapRegion = State(initialValue: MKCoordinateRegion(center: location, span: span))
        self.markers = [PlaceMarker(location: MapMarker(coordinate: location, tint: .red))]
        self._showDetail = State(initialValue: false)
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: markers) { marker in
                marker.location
            }
            .ignoresSafeArea(.all, edges: [.bottom])

            Button {
                showDetail.toggle()
            } label: {
                PlaceCellView(feature: feature)
                    .padding(10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(13)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
        }
        .navigationTitle(feature.properties.nazev)
        .sheet(isPresented: $showDetail) {
            PlaceDetailInfo(feature: feature)
                .presentationDetents([.medium])
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    onTapFavorite()
                } label: {
                    Image(systemName: favorites.contains(feature) ? "heart.fill" : "heart")
                }
            }
        }
    }

    func onTapFavorite() {
        if favorites.contains(feature) {
            favorites.removeAll(where: {$0.properties.ogcFid == feature.properties.ogcFid})
        } else {
            favorites.append(feature)
        }
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(feature: Features.mock.features.first!, favorites: .constant([]))
    }
}
