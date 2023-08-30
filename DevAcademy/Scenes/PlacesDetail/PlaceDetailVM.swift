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

class PlaceDetailVM: ObservableObject {
    @Published var showDetail: Bool
    var mapRegion: MKCoordinateRegion
    var placesObservable: PlacesObservable
    var place: Place
    let markers: [PlaceMarker]

    init(for place: Place, placeManager: PlacesObservable) {
        self.place = place
        self.placesObservable = placeManager
        self.showDetail = false

        let lat = place.geometry?.latitude ?? 0
        let long = place.geometry?.longitude ?? 0
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        self.mapRegion = MKCoordinateRegion(center: location, span: span)
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
        Binding { [weak self] in
            if let place = self?.place, let isFavorited = self?.placesObservable.isFavorited(place: place) {
                return isFavorited
            }
            return false
        } set: { [weak self] value in
            if let place = self?.place {
                self?.placesObservable.setFavorite(place: place, value: value)
            }
        }
    }
}
