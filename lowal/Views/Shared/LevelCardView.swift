import SwiftUI

struct LevelCardView: View {
    enum CardType {
        case animal(AnimalType)
        case plant(PlantCategory?)
    }
    
    enum AnimalType {
        case cow
        case pig
        case chicken
    }
    
    enum PlantCategory {
        case vegetables
        case fruits
        case grains
    }
    
    let level: Int
    let title: String
    let description: String
    let type: CardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with badge and title
            HStack(spacing: 16) {
                // Level and icon badge
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(getLevelColor())
                        .frame(width: 60, height: 60)
                    
                    // Icon based on animal type or plant category
                    Text(getIconEmoji())
                        .font(.system(size: 30))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        // Level circle
                        ZStack {
                            Circle()
                                .fill(getLevelColor().opacity(0.2))
                                .frame(width: 28, height: 28)
                            
                            Text("\(level)")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(getLevelColor())
                        }
                        
                        Text(title)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black) // Default text color
                    }
                    
                    // Type label (cow, pig, chicken, vegetables, etc.)
                    Text(getTypeLabel())
                        .font(.subheadline)
                        .foregroundColor(.secondary) // Secondary text color
                }
                
                Spacer()
            }
            
            // Description text
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary) // Secondary text color
                .lineLimit(3)
                .padding(.top, 4)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    private func getLevelColor() -> Color {
        switch level {
        case 5: return .green
        case 4: return Color(red: 0.2, green: 0.6, blue: 0.2)
        case 3: return .yellow
        case 2: return .orange
        case 1: return .red
        default: return .gray
        }
    }
    
    private func getIconEmoji() -> String {
        switch type {
        case .animal(let animalType):
            switch animalType {
            case .cow: return "🐄"
            case .pig: return "🐖"
            case .chicken: return "🐓"
            }
        case .plant(let category):
            if let category = category {
                switch category {
                case .vegetables: return "🥕"
                case .fruits: return "🍎"
                case .grains: return "🌾"
                }
            } else {
                return "🌱"
            }
        }
    }
    
    private func getTypeLabel() -> String {
        switch type {
        case .animal(let animalType):
            switch animalType {
            case .cow: return "Cow welfare"
            case .pig: return "Pig welfare"
            case .chicken: return "Chicken welfare"
            }
        case .plant(let category):
            if let category = category {
                switch category {
                case .vegetables: return "Vegetable sustainability"
                case .fruits: return "Fruit sustainability"
                case .grains: return "Grain sustainability"
                }
            } else {
                return "Plant sustainability"
            }
        }
    }
}

#Preview {
    VStack {
        LevelCardView(
            level: 5,
            title: "Outstanding welfare",
            description: "Animals live mostly outdoors with ample space and high-quality feed.",
            type: .animal(.cow)
        )
        .padding()
        
        LevelCardView(
            level: 4,
            title: "Advanced sustainability",
            description: "Organic farming with sustainable practices and biodiversity focus.",
            type: .plant(.vegetables)
        )
        .padding()
    }
    .background(Color(white: 0.98)) // Light background color
} 