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
    private let location: UserLocationService

    init(with service: PlacesService, location: UserLocationService) {
        self.service = service
        self.location = location
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
            self.rawPlaces = result.places
        } catch {
        }
    }

    func isFavorited(place: Place) -> Bool {
        if let fav = favorites {
            if fav.contains(where: {$0 == place.properties.ogcFid}) {
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
            favorites?.removeAll(where: {$0 == place.properties.ogcFid})
        }
    }

    func updatePlaces() {
        places.append(contentsOf: rawPlaces)

        if let fav = favorites {
            for id in fav {
                if let index = places.firstIndex(where: {$0.properties.ogcFid == id}) {
                    let element = places.remove(at: index)
                    places.insert(element, at: 0)
                }
            }
        }
    }
}
