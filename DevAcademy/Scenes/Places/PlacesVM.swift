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
        placesObservable.places.filter { place in
            if let favs = placesObservable.favorites {
                return favs.contains(where: {$0 == place.properties.ogcFid })
            }
            return false
        }
    }

    var placesAreLoaded: Bool {
        !places.isEmpty
    }

    func fetch() async {
        await placesObservable.fetchPlaces()
    }
}
