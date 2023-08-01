//
// Filename: PlaceDetailInfo.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI

struct PlaceDetailInfo: View {
    let feature: Feature
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 30, height: 3)
                .foregroundColor(.gray)
            AsyncImage(
                url: feature.properties.obrId1,
                content: { image in
                    image
                        .resizable()
                        .frame(maxHeight: 200)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(13)
                        .shadow(radius: 5)
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
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .font(.body)
        }
        .padding(10)
        Spacer()
    }
}

struct PlaceDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailInfo(feature: Features.mock.features.first!)
    }
}
