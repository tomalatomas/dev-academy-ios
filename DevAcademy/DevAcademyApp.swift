import SwiftUI

@main
struct DevAcademyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PlacesObservable())
                .environmentObject(Coordinator())
        }
    }
}
