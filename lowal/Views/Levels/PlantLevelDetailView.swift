import SwiftUI

struct PlantLevelDetailView: View {
    let level: PlantSustainabilityLevel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header with badge and title
                HStack(spacing: 16) {
                    LevelBadgeView(level: level.level, category: .plant)
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(level.level) \(level.title)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let category = level.plantCategory {
                            Text(getPlantCategoryName(for: category))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } else {
                            Text("All plant categories")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.bottom, 8)
                
                // Description
                Text(level.description)
                    .font(.body)
                    .padding(.bottom, 16)
                
                // Key characteristics
                Text("Key characteristics")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(level.keyCharacteristics, id: \.self) { characteristic in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 18))
                            
                            Text(characteristic)
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.bottom, 16)
                
                // What does this mean section
                VStack(alignment: .leading, spacing: 12) {
                    Text("What does this mean?")
                        .font(.headline)
                    
                    Text("Farming at this level focuses on sustainable practices that reduce chemical inputs, enhance soil health, and promote biodiversity. This approach not only results in healthier produce but also helps to protect our environment for future generations.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Level \(level.level) \(level.title)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getPlantCategoryName(for category: PlantSustainabilityLevel.PlantCategory) -> String {
        switch category {
        case .vegetables: return "Vegetables"
        case .fruits: return "Fruits"
        case .grains: return "Grains"
        }
    }
} 