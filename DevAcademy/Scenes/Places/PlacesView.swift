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

struct PlacesView: View {
    @State var features: [Feature] = Features.mock.features
    var body: some View {
        NavigationStack {
            Group {
                if !features.isEmpty {
                    List(features, id:\.properties.ogcFid){ feature in
                        PlaceCellView(feature: feature)
                            .onTapGesture {
                                onFeatureTapped(feature: feature)
                            }
                    }
                    .animation(.easeInOut, value: features)
                    .listStyle(.plain)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Kultůrmapa")
        }
        .onAppear(perform: fetch)
    }
    
    func onFeatureTapped(feature: Feature) {
        features.removeAll(where: {$0.properties.ogcFid == feature.properties.ogcFid})
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
