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
    var rawPlaces: [Place] = [] {
        didSet {
            updatePlaces()
        }
    }

    private(set) var favorites: [Int]? {
        get { UserDefaults.standard.array(forKey: "favourites") as? [Int] }
        set {
            UserDefaults.standard.set(newValue, forKey: "favourites")
            updatePlaces()
        }
    }

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

    func isFavorited(place: Place) -> Bool {
        if let fav = favorites {
            if fav.contains(where: {$0 == place.properties.ogcFid}) {
                return true
            }
        }
        return false
    }

    func addToFavorites(place: Place) {
        if isFavorited(place: place) {
            favorites?.removeAll(where: {$0 == place.properties.ogcFid})
        } else {
            favorites?.append(place.properties.ogcFid)
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
