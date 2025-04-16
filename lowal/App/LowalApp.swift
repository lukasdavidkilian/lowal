import SwiftUI

@main
struct LowalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            FarmMapView()
                .tabItem {
                    Label("Karte", systemImage: "map")
                }
            
            SettingsView()
                .tabItem {
                    Label("Einstellungen", systemImage: "gear")
                }
        }
    }
} 