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

import SwiftUI
import MapKit

struct PlaceDetailVM: DynamicProperty {
    var place: Place
    @State var showDetail: Bool
    @State var mapRegion: MKCoordinateRegion
    let markers: [PlaceMarker]

    init(for place: Place) {
        self.place = place
        self._showDetail = State(initialValue: false)

        //TODO: Assign latitude and longitude from "place"
        let location = CLLocationCoordinate2D(latitude: (Places.mock.places.first?.geometry!.latitude)!,
                                              longitude: (Places.mock.places.first?.geometry!.longitude)!)
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
}
