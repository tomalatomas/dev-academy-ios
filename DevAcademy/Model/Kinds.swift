//
// Filename: Kinds.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation

enum Kind: String, Codable {
    case theathre = "Divadlo"
    case gallery = "Galerie"
    case hub = "Hub"
    case musicClub = "Hudebni klub"
    case cinema = "Kino"
    case library = "Knihovna"
    case concertHall = "Koncertní hala"
    case cultureCentre = "Kulturní centrum"
    case monument = "Kulturní památka"
    case summerCinema = "Letní kino"
    case museum = "Muzeum"
    case cultureProgramme = "Podnik s kulturním programem"
    case expo = "Výstaviště"
    case other = "Ostatní"

    enum CodingKeys: String, CodingKey {
        case cinema = "kino"
        case theathre = "divadlo"
        case gallery = "galerie"
        case musicClub = "hudebniKlub"
        case library = "knihovna"
        case concertHall = "koncertniHala"
        case cultureCentre = "kulturniCentrum"
        case monument = "kulturniPamátka"
        case summerCinema = "letniKino"
        case museum = "muzeum"
        case cultureProgramme = "podnikSLulturnimProgramem"
        case expo = "vystaviste"
        case other = "ostatni"
        case hub

    }
}

enum PossibleKind: RawRepresentable, Codable {
    init?(rawValue: String) {
        if let kindCase = Kind(rawValue: rawValue) {
            self = .kind(kindCase)
        } else {
            self = .unknown(rawValue)
        }
    }

    var rawValue: String {
        switch self {
        case .kind(let type): return type.rawValue
        case .unknown(let text): return text
        }
    }

    typealias RawValue = String

    case kind(Kind)
    case unknown(String)
}
