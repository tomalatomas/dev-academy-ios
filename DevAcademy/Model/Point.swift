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

struct Point: Codable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "x"
        case longitude = "y"
    }
}
