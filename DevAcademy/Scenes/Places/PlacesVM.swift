//
// Filename: PlacesVM.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI

struct PlacesVM: DynamicProperty {
    @State var showFavorites: Bool = false
    @EnvironmentObject private var placesObservable: PlacesObservable

    var places: [Place] {
        placesObservable.places
    }

    var favorites: [Place] {
        placesObservable.favorites
    }

    var placesAreLoaded: Bool {
        !places.isEmpty
    }

    func fetch() async {
        await placesObservable.fetchPlaces()
    }

    func addToFavorites(place: Place) {
        placesObservable.addToFavorites(place: place)
    }
}
