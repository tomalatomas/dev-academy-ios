//
// Filename: PlacesView.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI
import ActivityIndicatorView

struct PlacesView: View {
    @EnvironmentObject private var coordinator: Coordinator
    let placesVM: PlacesVM = PlacesVM()

    var body: some View {
        NavigationStack {
            Group {
                if !placesVM.places.isEmpty {
                    List(placesVM.places, id: \.properties.ogcFid) { place in
                        NavigationLink {
                            coordinator.placeDetailScene(for: place)
                        } label: {
                            PlaceCellView(place: place)
                        }
                    }
                    .animation(.easeInOut, value: placesVM.places)
                    .listStyle(.plain)
                } else {
                    ActivityIndicatorView(isVisible: .constant(true),
                                          type: .opacityDots(count: 5, inset: 10))
                    .frame(width: 100)
                }
            }
            .navigationTitle("Kultůrmapa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        placesVM.showFavorites.toggle()
                    } label: {
                        Image(systemName: "heart")
                    }
                }
            }
        }
        .task {
            await placesVM.fetch()
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
