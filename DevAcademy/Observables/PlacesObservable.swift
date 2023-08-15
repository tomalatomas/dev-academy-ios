//
// Filename: PlacesObservable.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI

class PlacesObservable: ObservableObject {
    @Published var places: [Place] = []
    @Published var favorites: [Place] = []
    private let service: PlacesService

    init(with service: PlacesService) {
        self.service = service
    }

    @MainActor
    func fetchPlaces() async {
        do {
            let result = try await service.places()
            self.places = result.places
        } catch {
        }
    }

    func addToFavorites(place: Place) {
        if favorites.contains(place) {
            favorites.removeAll(where: {$0.properties.ogcFid == place.properties.ogcFid})
        } else {
            favorites.append(place)
        }
    }
}
