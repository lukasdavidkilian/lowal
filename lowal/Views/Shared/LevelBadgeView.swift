import SwiftUI

struct LevelBadgeView: View, Hashable {
    let level: Int
    let category: BadgeCategory
    
    enum BadgeCategory: Hashable {
        case cow
        case pig
        case chicken
        case plant
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: 32, height: 32)
            
            HStack(spacing: 2) {
                Image(systemName: iconName)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                
                Text("\(level)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
    
    private var backgroundColor: Color {
        switch level {
        case 5: return Color.green
        case 4: return Color.mint
        case 3: return Color.yellow
        case 2: return Color.orange
        case 1: return Color.red
        default: return Color.gray
        }
    }
    
    private var iconName: String {
        switch category {
        case .cow: return "hare.fill"
        case .pig: return "pawprint.fill"
        case .chicken: return "bird.fill"
        case .plant: return "leaf.fill"
        }
    }
    
    // MARK: - Hashable Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(level)
        hasher.combine(category.hashValue)
    }
    
    static func == (lhs: LevelBadgeView, rhs: LevelBadgeView) -> Bool {
        return lhs.level == rhs.level && lhs.category == rhs.category
    }
} 