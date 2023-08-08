//
// Filename: Coordinator.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI

class Coordinator: ObservableObject {

    var placesScene: some View {
        PlacesView()
    }

    func placeDetailScene(for place: Place) -> some View {
        PlaceDetail(placeDetailVM: PlaceDetailVM(for: place))
    }

}
