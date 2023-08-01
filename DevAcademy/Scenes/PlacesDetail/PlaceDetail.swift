//
// Filename: PlaceDetail.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI

struct PlaceDetail: View {
    var feature: Feature
    
    var body: some View {
        VStack {
            Text(feature.properties.nazev)
        }
        .navigationTitle(feature.properties.nazev)
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        //PlaceDetail(feature: .constant(Features.mock.features.first!))
        PlaceDetail(feature: Features.mock.features.first!)
    }
}
