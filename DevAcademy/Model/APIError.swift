//
// Filename: APIError.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation

enum APIError: Error {
    case invalidData
    case invalidResponse
    case decodingError(Error)
}
