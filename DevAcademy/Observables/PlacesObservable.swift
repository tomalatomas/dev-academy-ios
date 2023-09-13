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
    private let service: PlacesService

    init(with service: PlacesService) {
        self.service = service
    }

    var rawPlaces: [Place] = [] {
        didSet {
            updatePlaces()
        }
    }

    private(set) var favorites: [Int]? {
        get { (UserDefaults.standard.array(forKey: "favourites") ?? []) as? [Int] }
        set {
            UserDefaults.standard.set(newValue, forKey: "favourites")
            updatePlaces()
        }
    }

    @MainActor
    func fetchPlaces() async {
        do {
            let result = try await service.places()
            rawPlaces = result.places
        } catch {}
    }

    func isFavorited(place: Place) -> Bool {
        if let fav = favorites {
            if fav.contains(where: { $0 == place.properties.ogcFid }) {
                return true
            }
        }
        return false
    }

    func setFavorite(place: Place, value: Bool) {
        if value {
            if !isFavorited(place: place) {
                // Add to favorites if not added yet
                favorites?.append(place.properties.ogcFid)
            }
        } else {
            // Remove all occurences
            favorites?.removeAll(where: { $0 == place.properties.ogcFid })
        }
    }

    func updatePlaces() {
        var updatedPlaces = rawPlaces

        if let fav = favorites {
            for id in fav {
                if let index = updatedPlaces.firstIndex(where: { $0.properties.ogcFid == id }) {
                    let element = updatedPlaces.remove(at: index)
                    updatedPlaces.insert(element, at: 0)
                }
            }

            places = updatedPlaces
        }
    }
}
