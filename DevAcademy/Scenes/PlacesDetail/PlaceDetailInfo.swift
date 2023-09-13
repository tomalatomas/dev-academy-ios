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
    let state: PlaceDetailVM

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 30, height: 3)
                .foregroundColor(.gray)
            AsyncImage(
                url: state.placeImage,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(13)
                        .shadow(radius: 5)
                        .clipped()
                },
                placeholder: {
                    ProgressView()
                }
            )
            Text(state.placeType)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        Spacer()
    }
}
