import SwiftUI

struct CO2BadgeView: View {
    let reduction: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "leaf.fill")
                .foregroundColor(.green)
            
            Text("–\(reduction)% less CO₂e")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.green)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.green.opacity(0.15))
        )
    }
} 