import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlacesView()
                .tabItem {
                    Label("Places", systemImage: "mappin.circle.fill")
                }
            
            Color.red
                .tabItem {
                    Label("Next Tab", systemImage: "heart.fill")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
