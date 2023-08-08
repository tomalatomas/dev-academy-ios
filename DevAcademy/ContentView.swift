import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        coordinator.placesScene
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlacesObservable())
            .environmentObject(Coordinator())
    }
}
