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
    @State var features: [Feature] = Features.mock.features
    @State var showFavorites: Bool = false
    @State var favorites: [Feature] = []

    var body: some View {
        NavigationStack {
            Group {
                if !features.isEmpty {
                    List(features, id: \.properties.ogcFid) { feature in
                        NavigationLink {
                            PlaceDetail(feature: feature, favorites: $favorites)
                        } label: {
                            PlaceCellView(feature: feature)
                        }
                    }
                    .animation(.easeInOut, value: features)
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
                        showFavorites.toggle()
                    } label: {
                        Image(systemName: "heart")
                    }
                }
            }
        }
        .onAppear(perform: fetch)
        .sheet(isPresented: $showFavorites) {
            List(favorites, id: \.properties.ogcFid) { feature in
                PlaceCellView(feature: feature)
                    .onTapGesture {
                        onFavoriteTapped(feature: feature)
                    }
            }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }

    func onFavoriteTapped(feature: Feature) {
        favorites.removeAll(where: {$0.properties.ogcFid == feature.properties.ogcFid})
    }

    func fetch() {
        DataService.shared.fetchData { result in
            switch result {
            case .success(let features):
                self.features = features.features
            case .failure(let err):
                print(err)
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
