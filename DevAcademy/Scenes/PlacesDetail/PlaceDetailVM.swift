//
// Filename: PlaceDetailVM.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import MapKit
import SwiftUI

struct PlaceDetailVM: DynamicProperty {
    @State var showDetail: Bool
    @State var mapRegion: MKCoordinateRegion
    @EnvironmentObject private var placesObservable: PlacesObservable
    var place: Place
    let markers: [PlaceMarker]

    init(for place: Place) {
        self.place = place
        self._showDetail = State(initialValue: false)

        let lat = place.geometry?.latitude ?? 0
        let long = place.geometry?.longitude ?? 0
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        self._mapRegion = State(initialValue: MKCoordinateRegion(center: location, span: span))
        self.markers = [PlaceMarker(location: MapMarker(coordinate: location, tint: .red))]
    }

    var placeName: String {
        place.properties.name
    }

    var placeType: String {
        place.properties.type.rawValue
    }

    var placeImage: URL? {
        place.properties.obrId1
    }

    var isFavorite: Binding<Bool> {
        Binding {
            placesObservable.isFavorited(place: place)
        } set: { value in
            placesObservable.setFavorite(place: place, value: value)
        }
    }
}
