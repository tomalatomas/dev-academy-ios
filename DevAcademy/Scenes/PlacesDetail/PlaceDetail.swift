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
    @Binding var favorites: [Feature]
    
    var body: some View {
        VStack(){
            AsyncImage(
                url: feature.properties.obrId1,
                content: { image in
                    image
                        .resizable()
                        .frame(maxHeight: 200)
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    ProgressView()

                }
            )
            Text(feature.properties.druh.rawValue)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
            Spacer()
        }
        .navigationTitle(feature.properties.nazev)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    if favorites.contains(feature) {
                        favorites.removeAll(where: {$0.properties.ogcFid == feature.properties.ogcFid})
                    } else {
                        favorites.append(feature)
                    }
                } label: {
                    Image(systemName: favorites.contains(feature) ? "heart.fill" : "heart")
                }
            }
        }
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        //PlaceDetail(feature: .constant(Features.mock.features.first!))
        PlaceDetail(feature: Features.mock.features.first!, favorites: .constant([]))
    }
}
