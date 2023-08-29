//
// Filename: Properties.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation

struct Properties: Codable {
    let ogcFid: Int
    var obrId1: URL?
    let type: PossibleKind
    let name: String
    var web: String?
    var phone: String?
    var email: String?

    enum CodingKeys: String, CodingKey {
        case ogcFid = "ogc_fid"
        case obrId1 = "obr_id1"
        case phone =  "telefon"
        case type = "druh"
        case name = "nazev"

        case web
        case email
    }
}
