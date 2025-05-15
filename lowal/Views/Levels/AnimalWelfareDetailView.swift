import SwiftUI

struct AnimalWelfareDetailView: View {
    let level: AnimalWelfareLevel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header with badge and title
                HStack(spacing: 16) {
                    // Level icon with animal emoji
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(getLevelColor())
                            .frame(width: 80, height: 80)
                        
                        // Animal emoji
                        Text(getAnimalEmoji())
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
                        
                        Text(getAnimalName(for: level.animalType))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
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
                    
                    Text("This level ensures that \(getAnimalNamePlural(for: level.animalType)) live mostly outdoors when conditions allow, have room to move, and are cared for without routine interventions like dehorning or antibiotics. It's one step below organic - but still a major improvement over standard practices.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .navigationTitle("\(getAnimalName(for: level.animalType)) - Level \(level.level)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getAnimalName(for type: AnimalWelfareLevel.AnimalType) -> String {
        switch type {
        case .cow: return "Cow welfare"
        case .pig: return "Pig welfare"
        case .chicken: return "Chicken welfare"
        }
    }
    
    private func getAnimalNamePlural(for type: AnimalWelfareLevel.AnimalType) -> String {
        switch type {
        case .cow: return "cows"
        case .pig: return "pigs"
        case .chicken: return "chickens"
        }
    }
    
    private func getAnimalEmoji() -> String {
        switch level.animalType {
        case .cow: return "🐄"
        case .pig: return "🐖"
        case .chicken: return "🐓"
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