//
// Filename: DataService.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Foundation

class DataService {
    static var shared: DataService = DataService()
    
    private init(){
    }
}

extension DataService {
    private static var mockData: Features = Features(features: [])
}
