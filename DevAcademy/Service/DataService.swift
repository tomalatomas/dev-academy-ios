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
    var data: Result<Places, Error>?
    
    private init(){
    }
    
    func fetchData(action: @escaping (Result<Places, Error>) -> Void) {
        if let data {
            action(data)
            return
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] timer in
            let mockData = Places.mock
            self?.data = .success(mockData)
            action(self?.data ?? .success(mockData))
        }
    }
}

extension DataService {
    private static var mockData: Places = Places(places: [])
}
