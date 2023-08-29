//
// Filename: Place.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation

struct Place: Equatable, Codable {
    let geometry: Point?
    let properties: Properties

    static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.properties.ogcFid == rhs.properties.ogcFid
    }

    enum CodingKeys: String, CodingKey {
        case properties = "attributes"
        case geometry
    }
}

struct Places: Codable {
    let places: [Place]

    enum CodingKeys: String, CodingKey {
        case places = "features"
    }
}

extension Places {
    static let mock: Places = Places(
        places: [
            Place(
                geometry: Point(latitude: 49.1913, longitude: 16.6115),
                properties: Properties(
                    ogcFid: 1,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.cinema),
                    name: "Národní divadlo Brno"
                )
            ),
            Place(
                geometry: Point(latitude: 49.2006, longitude: 16.6097),
                properties: Properties(
                    ogcFid: 2,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.cinema),
                    name: "Kino Art Brno"
                )
            ),
            Place(
                geometry: Point(latitude: 49.2019, longitude: 16.6151),
                properties: Properties(
                    ogcFid: 3,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.museum),
                    name: "Moravské zemské muzeum"
                )
            ),
            Place(
                geometry: Point(latitude: 49.2079, longitude: 16.5938),
                properties: Properties(
                    ogcFid: 4,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.monument),
                    name: "BOUFOU Prostějovská Brno"
                )
            ),
            Place(
                geometry: Point(latitude: 49.2072, longitude: 16.6061),
                properties: Properties(
                    ogcFid: 5,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.musicClub),
                    name: "Kabinet múz"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1894, longitude: 165602),
                properties: Properties(
                    ogcFid: 6,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.library),
                    name: "Moravská zemská knihovna"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1914, longitude: 16.6126),
                properties: Properties(
                    ogcFid: 7,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.concertHall),
                    name: "Janáčkovo divadlo"
                )
            ),
            Place(
                geometry: Point(latitude: 49.2182, longitude: 16.5893),
                properties: Properties(
                    ogcFid: 8,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.monument),
                    name: "Špilberk Brno"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1920, longitude: 16.6071),
                properties: Properties(
                    ogcFid: 9,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.summerCinema),
                    name: "Letní kino Lužánky"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1925, longitude: 16.6112),
                properties: Properties(
                    ogcFid: 10,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.cultureProgramme),
                    name: "Bar, který neexistuje"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1925, longitude: 16.6112),
                properties: Properties(
                    ogcFid: 11,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.cinema),
                    name: "Cinema City"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1925, longitude: 16.6112),
                properties: Properties(
                    ogcFid: 12,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.cinema),
                    name: "Univerzitní kino Scala"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1925, longitude: 16.6112),
                properties: Properties(
                    ogcFid: 13,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.hub),
                    name: "Impact Hub"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1925, longitude: 16.6112),
                properties: Properties(
                    ogcFid: 14,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.monument),
                    name: "Villa Tugendhat"
                )
            ),
            Place(
                geometry: Point(latitude: 49.1925, longitude: 16.6112),
                properties: Properties(
                    ogcFid: 15,
                    obrId1: URL(string: "https://picsum.photos/200")!,
                    type: .kind(.expo),
                    name: "Brněnské výstaviště"
                )
            )
        ]
    )
}
