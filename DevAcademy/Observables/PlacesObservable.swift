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
    private let service = DataService.shared
    
    func fetchPlaces() {
        service.fetchData { result in
            switch result {
            case .success(let places):
                self.places = places.places
            case .failure(let err):
                print(err)
            }
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
