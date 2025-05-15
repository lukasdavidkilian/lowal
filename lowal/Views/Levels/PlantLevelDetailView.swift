import SwiftUI

struct PlantLevelDetailView: View {
    let level: PlantSustainabilityLevel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header with badge and title
                HStack(spacing: 16) {
                    // Level icon with plant emoji
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(getLevelColor())
                            .frame(width: 80, height: 80)
                        
                        // Plant emoji
                        Text(getPlantEmoji())
                            .font(.system(size: 40))
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            // Level circle
                            ZStack {
                                Circle()
                                    .fill(getLevelColor().opacity(0.2))
                                    .frame(width: 32, height: 32)
                                
                                Text("\(level.level)")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(getLevelColor())
                            }
                            
                            Text(level.title)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
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
                .padding(.bottom, 16)
                
                // Description
                Text(level.description)
                    .font(.body)
                    .padding(.bottom, 16)
                
                // Divider
                Rectangle()
                    .fill(Color.secondary.opacity(0.2))
                    .frame(height: 1)
                    .padding(.vertical, 8)
                
                // Key characteristics
                Text("Key characteristics")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(level.keyCharacteristics, id: \.self) { characteristic in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(getLevelColor())
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
            .background(Color.white)
        }
        .background(Color.white)
        .navigationTitle("Plant Sustainability - Level \(level.level)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getPlantCategoryName(for category: PlantSustainabilityLevel.PlantCategory) -> String {
        switch category {
        case .vegetables: return "Vegetable sustainability"
        case .fruits: return "Fruit sustainability"
        case .grains: return "Grain sustainability"
        }
    }
    
    private func getPlantEmoji() -> String {
        if let category = level.plantCategory {
            switch category {
            case .vegetables: return "🥕"
            case .fruits: return "🍎"
            case .grains: return "🌾"
            }
        } else {
            return "🌱"
        }
    }
    
    private func getLevelColor() -> Color {
        switch level.level {
        case 5: return .green
        case 4: return Color(red: 0.2, green: 0.6, blue: 0.2)
        case 3: return .yellow
        case 2: return .orange
        case 1: return .red
        default: return .gray
        }
    }
} 