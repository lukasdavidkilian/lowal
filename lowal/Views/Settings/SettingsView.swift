import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Anzeigeeinstellungen")) {
                    NavigationLink(destination: AnimalWelfareListView(animalType: .cow)) {
                        HStack {
                            Image(systemName: "hare")
                                .foregroundColor(.brown)
                                .frame(width: 30)
                            Text("Tierwohl-Level")
                        }
                    }
                    
                    NavigationLink(destination: PlantLevelListView()) {
                        HStack {
                            Image(systemName: "leaf")
                                .foregroundColor(.green)
                                .frame(width: 30)
                            Text("Pflanzen-Nachhaltigkeitsstufen")
                        }
                    }
                }
                
                Section(header: Text("Über")) {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Version 1.0")
                    }
                    
                    HStack {
                        Image(systemName: "doc.text")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Datenschutzrichtlinien")
                    }
                    
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Feedback senden")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
} 