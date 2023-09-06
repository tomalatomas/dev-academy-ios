//
// Filename: Point.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation
import CoreLocation

struct Point: Codable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "y"
        case longitude = "x"
    }
}

extension Point {
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
