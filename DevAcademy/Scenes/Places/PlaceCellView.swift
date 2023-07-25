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
    // @Binding var feature: Feature
    var feature: Feature

    var body: some View {
        HStack {
            AsyncImage(
                url: feature.properties.obrId1,
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
                Text(feature.properties.nazev)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(feature.properties.druh.rawValue)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}

struct PlaceCellView_Previews: PreviewProvider {
    static var previews: some View {
        // PlaceCellView(feature: .constant(Features.mock.features.first!))
        PlaceCellView(feature: Features.mock.features.first!)
    }
}
