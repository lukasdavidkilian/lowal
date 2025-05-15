import SwiftUI

struct AnimalWelfareDetailView: View {
    let level: AnimalWelfareLevel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header with badge and title
                HStack(spacing: 16) {
                    AnimalLevelIconView(level: level.level, animalType: level.animalType)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(level.level) \(level.title)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(getAnimalName(for: level.animalType))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
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
                    
                    Text("This level ensures that \(getAnimalNamePlural(for: level.animalType)) live mostly outdoors when conditions allow, have room to move, and are cared for without routine interventions like dehorning or antibiotics. It's one step below organic - but still a major improvement over standard practices.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("\(getAnimalName(for: level.animalType)) - \(level.level) \(level.title)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getAnimalName(for type: AnimalWelfareLevel.AnimalType) -> String {
        switch type {
        case .cow: return "Cow"
        case .pig: return "Pig"
        case .chicken: return "Chicken"
        }
    }
    
    private func getAnimalNamePlural(for type: AnimalWelfareLevel.AnimalType) -> String {
        switch type {
        case .cow: return "cows"
        case .pig: return "pigs"
        case .chicken: return "chickens"
        }
    }
} 