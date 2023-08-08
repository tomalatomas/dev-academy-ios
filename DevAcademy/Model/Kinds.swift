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

enum Kind: String {
    case divadlo = "Divadlo"
    case galerie = "Galerie"
    case hub = "Hub"
    case hudebniKlub = "Hudebni klub"
    case kino = "Kino"
    case knihovna = "Knihovna"
    case koncertniHala = "Koncertní hala"
    case kulturniCentrum = "Kulturní centrum"
    case kulturniPamátka = "Kulturní památka"
    case letniKino = "Letní kino"
    case muzeum = "Muzeum"
    case podnikSLulturnimProgramem = "Podnik s kulturním programem"
    case vystaviste = "Výstaviště"
    case ostatni = "Ostatní"
}

enum PossibleKind: RawRepresentable {
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
