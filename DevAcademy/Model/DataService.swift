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
    var data: Result<Features, Error>?
    
    private init(){
    }
    
    func fetchData(action: (Result<Features, Error>) -> Void) {
        if let data {
            action(data)
            return()
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [self] timer in
            data = .success(DataService.mockData)
        }
    }
}

extension DataService {
    private static var mockData: Features = Features(features: [])
}
