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
import CoreLocation

class PlacesObservable: ObservableObject {
    @Published var places: [Place] = []
    private let service: PlacesService
    private let location: UserLocationService
    private var lastUserLocation: CLLocation?

    init(with service: PlacesService, location: UserLocationService) {
        self.service = service
        self.location = location

        self.location.listenDidUpdateLocation { [weak self] location in
            guard let userLocation = location.first else { return }
            guard let toUpdate = self?.shouldUpdate(location: userLocation) else { return }
            if toUpdate {
                print("Update")
                self?.lastUserLocation = userLocation
                self?.updatePlaces()
            }
        }

        self.location.listenDidUpdateStatus { [weak self] status in
            switch status {
            case .notDetermined:
                self?.location.requestAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                self?.beginLocationUpdates()
            default: break
            }
        }
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
        var updatedPlaces = rawPlaces

        if let lastUserLocation {
            updatedPlaces.sort { lPlace, rPlace in
                guard let rPoint = rPlace.geometry?.location else {
                    return false
                }
                guard let lPoint = lPlace.geometry?.location else {
                    return true
                }

                return lastUserLocation.distance(from: lPoint).magnitude < lastUserLocation.distance(from: rPoint).magnitude
            }
        }

        if let fav = favorites {
            for id in fav {
                if let index = updatedPlaces.firstIndex(where: {$0.properties.ogcFid == id}) {
                    let element = updatedPlaces.remove(at: index)
                    updatedPlaces.insert(element, at: 0)
                }
            }
            self.places = updatedPlaces
        }
    }

    func beginLocationUpdates() {
        self.location.startUpdatingLocation()
    }

    func shouldUpdate(location: CLLocation) -> Bool {
        guard let lastLocation = lastUserLocation else {
            return true
        }

        return lastLocation.distance(from: location).magnitude > 100
    }
}
