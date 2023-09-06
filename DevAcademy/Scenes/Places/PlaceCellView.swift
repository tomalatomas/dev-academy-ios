//
// Filename: PlaceCellView.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI

struct PlaceCellView: View {
    var place: Place

    var body: some View {
        HStack {
            StoredAsyncImage(url: place.properties.obrId1) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 4)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(place.properties.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(place.properties.type.rawValue)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}

struct PlaceCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCellView(place: Places.mock.places.first!)
    }
}
