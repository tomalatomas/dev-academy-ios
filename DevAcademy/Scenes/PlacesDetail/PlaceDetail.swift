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
    private let markers: [PlaceMarker]
    @State private var showDetail: Bool
    
    init(feature: Feature, favorites: Binding<[Feature]>) {
        self.feature = feature
        self._favorites = favorites
        self._mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        self.markers = [PlaceMarker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude), tint: .red))]
        self._showDetail = State(initialValue: false)
    }


    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: markers){_ in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: feature.geometry.latitude, longitude: feature.geometry.longitude))
            }
            .ignoresSafeArea(.all, edges: [.bottom])
            VStack{
                Spacer()
                Button {
                    showDetail.toggle()
                } label: {
                    PlaceCellView(feature: feature)
                        .padding(10)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(13)
                }
            }
            .padding(10)
        }
        .sheet(isPresented: $showDetail){
            PlaceDetailInfo(feature: feature)
                .presentationDetents([.medium])
        }
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


