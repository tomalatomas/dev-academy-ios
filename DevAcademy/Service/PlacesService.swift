//
// Filename: PlacesService.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation

protocol PlacesService {
    func places() async throws -> Places
}

class ProductionPlacesService: PlacesService {
    func places() async throws -> Places {
        let session = URLSession.shared
        let url = URL(string: "https://gis.brno.cz/ags1/rest/services/OMI/omi_ok_kulturni_instituce/FeatureServer/0/query?where=1%3D1&outFields=ogc_fid,nazev,druh,web,email,telefon,obr_id1&outSR=4326&f=json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
            throw APIError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(Places.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIError.decodingError(error)
        }
    }
}

class MockPlacesService: PlacesService {
    func places() async throws -> Places {
        return Places.mock
    }
}
