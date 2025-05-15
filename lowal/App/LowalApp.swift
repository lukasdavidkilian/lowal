import SwiftUI

@main
struct LowalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            FarmMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            NavigationView {
                SustainabilityLevelsOverview()
            }
            .tabItem {
                Label("Level", systemImage: "leaf")
            }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(.green)
        .background(Color.backgroundLowal)
        .onAppear {
            // Set the background color for lists, navigation bars, etc.
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.backgroundLowal)
            appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.textLowal)]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.textLowal)]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            UITableView.appearance().backgroundColor = UIColor(Color.backgroundLowal)
            UITableViewCell.appearance().backgroundColor = UIColor(Color.backgroundLowal)
        }
    }
}

struct SustainabilityLevelsOverview: View {
    var body: some View {
        List {
            Section(header: Text("Animal Welfare Levels").foregroundColor(Color.textLowal)) {
                AnimalLevelsOverview()
            }
            
            Section(header: Text("Plant Sustainability Levels").foregroundColor(Color.textLowal)) {
                PlantLevelsOverview()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Sustainability Levels")
        .background(Color.backgroundLowal)
    }
}

struct AnimalLevelsOverview: View {
    var body: some View {
        Group {
            NavigationLink(destination: AnimalWelfareListView(animalType: .cow)) {
                HStack {
                    Image(systemName: "hare")
                        .foregroundColor(.brown)
                        .frame(width: 30)
                    Text("Cow Welfare Levels")
                        .foregroundColor(Color.textLowal)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            NavigationLink(destination: AnimalWelfareListView(animalType: .pig)) {
                HStack {
                    Image(systemName: "pawprint")
                        .foregroundColor(.brown)
                        .frame(width: 30)
                    Text("Pig Welfare Levels")
                        .foregroundColor(Color.textLowal)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            NavigationLink(destination: AnimalWelfareListView(animalType: .chicken)) {
                HStack {
                    Image(systemName: "bird")
                        .foregroundColor(.brown)
                        .frame(width: 30)
                    Text("Chicken Welfare Levels")
                        .foregroundColor(Color.textLowal)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct PlantLevelsOverview: View {
    var body: some View {
        Group {
            NavigationLink(destination: PlantLevelListView(plantCategory: .vegetables)) {
                HStack {
                    Image(systemName: "carrot")
                        .foregroundColor(.green)
                        .frame(width: 30)
                    Text("Vegetable Sustainability Levels")
                        .foregroundColor(Color.textLowal)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            NavigationLink(destination: PlantLevelListView(plantCategory: .fruits)) {
                HStack {
                    Image(systemName: "apple.logo")
                        .foregroundColor(.green)
                        .frame(width: 30)
                    Text("Fruit Sustainability Levels")
                        .foregroundColor(Color.textLowal)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            NavigationLink(destination: PlantLevelListView(plantCategory: .grains)) {
                HStack {
                    Image(systemName: "wheat")
                        .foregroundColor(.green)
                        .frame(width: 30)
                    Text("Grain Sustainability Levels")
                        .foregroundColor(Color.textLowal)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}