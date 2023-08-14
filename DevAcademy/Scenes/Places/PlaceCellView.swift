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
            AsyncImage(
                url: place.properties.obrId1,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 60, maxHeight: 60)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                },
                placeholder: {
                    ProgressView()
                }
            )
            VStack(alignment: .leading) {
                Text(place.properties.nazev)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(place.properties.druh.rawValue)
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
