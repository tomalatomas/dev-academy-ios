//
// Filename: PlaceMarker.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation
import _MapKit_SwiftUI

struct PlaceMarker: Identifiable {
    let id = UUID()
    var location: MapMarker
}
