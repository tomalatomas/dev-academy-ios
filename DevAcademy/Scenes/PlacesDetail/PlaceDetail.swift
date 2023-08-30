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
    @ObservedObject var placeDetailVM: PlaceDetailVM

    var body: some View {
        ZStack {
            Map(coordinateRegion: $placeDetailVM.mapRegion, annotationItems: placeDetailVM.markers) { marker in
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
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    placeDetailVM.isFavorite.wrappedValue.toggle()
                } label: {
                    Image(systemName: placeDetailVM.isFavorite.wrappedValue ? "heart.fill" : "heart")
                }
            }
        }
        .sheet(isPresented: $placeDetailVM.showDetail) {
            coordinator.placeInfoScene(with: placeDetailVM)
                .presentationDetents([.medium])
        }
    }
}
