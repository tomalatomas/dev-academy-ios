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
    
    func fetchData(action: @escaping (Result<Features, Error>?) -> Void) {
        if let data {
            action(data)
            return
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] timer in
            self?.data = .success(DataService.mockData)
            action(self?.data)
        }
    }
}

extension DataService {
    private static var mockData: Features = Features(features: [])
}
