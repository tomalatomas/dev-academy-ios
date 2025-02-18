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
import MapKit

struct PlaceDetail: View {
    @EnvironmentObject private var coordinator: Coordinator
    let placeDetailVM: PlaceDetailVM

    var body: some View {
        ZStack {
            Map(coordinateRegion: placeDetailVM.$mapRegion, annotationItems: placeDetailVM.markers) { marker in
                marker.location
            }
            .ignoresSafeArea(.all, edges: [.bottom])

            Button {
                placeDetailVM.showDetail.toggle()
            } label: {
                PlaceCellView(place: placeDetailVM.place)
                    .padding(10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(13)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
        }
        .navigationTitle(placeDetailVM.placeName)
        .sheet(isPresented: placeDetailVM.$showDetail) {
            coordinator.placeInfoScene(with: placeDetailVM)
                .presentationDetents([.medium])
        }
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(placeDetailVM: PlaceDetailVM(for: Places.mock.places[0]))
    }
}
