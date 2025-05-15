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
        HStack(spacing: 1) {
            Text(emojiIcon)
                .font(.system(size: 16))
            
            Text("\(level)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(levelColor)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(radius: 1)
        )
    }
    
    private var levelColor: Color {
        switch level {
        case 5: return Color.green
        case 4: return Color.mint
        case 3: return Color.yellow
        case 2: return Color.orange
        case 1: return Color.red
        default: return Color.gray
        }
    }
    
    private var emojiIcon: String {
        switch category {
        case .cow: return "🐄"
        case .pig: return "🐖"
        case .chicken: return "🐓"
        case .plant: return "🌱"
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