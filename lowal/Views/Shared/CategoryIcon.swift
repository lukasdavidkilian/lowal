import SwiftUI

struct CategoryIcon: View {
    let category: Product.ProductCategory
    let size: CGFloat
    
    init(category: Product.ProductCategory, size: CGFloat = 24) {
        self.category = category
        self.size = size
    }
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .foregroundColor(iconColor)
    }
    
    private var iconName: String {
        switch category {
        case .cow:
            return "hare"
        case .pig:
            return "pawprint"
        case .chicken:
            return "bird"
        case .vegetables:
            return "leaf"
        case .fruits:
            return "applelogo"
        case .grains:
            return "bolt"
        case .other:
            return "cart"
        }
    }
    
    private var iconColor: Color {
        switch category {
        case .cow, .pig, .chicken:
            return .brown
        case .vegetables, .fruits, .grains:
            return .green
        case .other:
            return .gray
        }
    }
} 