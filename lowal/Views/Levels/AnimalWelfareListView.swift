import SwiftUI

struct AnimalWelfareListView: View {
    @StateObject private var viewModel: AnimalWelfareViewModel
    @State private var showAnimalTypePicker = false
    
    init(animalType: AnimalWelfareLevel.AnimalType = .cow) {
        self._viewModel = StateObject(wrappedValue: AnimalWelfareViewModel(animalType: animalType))
    }
    
    var body: some View {
        List {
            // Animal type picker is hidden by default now that we have a dedicated overview screen
            if showAnimalTypePicker {
                Section {
                    Picker("Animal Type", selection: $viewModel.selectedAnimalType) {
                        Text("Cow").tag(AnimalWelfareLevel.AnimalType.cow)
                        Text("Pig").tag(AnimalWelfareLevel.AnimalType.pig)
                        Text("Chicken").tag(AnimalWelfareLevel.AnimalType.chicken)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8)
                }
            }
            
            ForEach(viewModel.filteredLevels) { level in
                NavigationLink(destination: AnimalWelfareDetailView(level: level)) {
                    HStack(spacing: 16) {
                        AnimalLevelIconView(level: level.level, animalType: viewModel.selectedAnimalType)
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(level.level) \(level.title)")
                                    .font(.headline)
                                    .foregroundColor(.textLowal)
                            }
                            
                            Text(level.description)
                                .font(.subheadline)
                                .foregroundColor(.textLowal.opacity(0.7))
                                .lineLimit(2)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.backgroundLowal)
                }
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color.backgroundLowal)
            }
            
            Section {
                Text("This overview simplifies complex practices to make them easier to understand. It's not perfect, but it's a starting point.")
                    .font(.caption)
                    .foregroundColor(.textLowal.opacity(0.6))
                    .padding(.vertical, 8)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(getNavigationTitle())
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.backgroundLowal)
    }
    
    private func getNavigationTitle() -> String {
        switch viewModel.selectedAnimalType {
        case .cow:
            return "Cow welfare levels"
        case .pig:
            return "Pig welfare levels"
        case .chicken:
            return "Chicken welfare levels"
        }
    }
}

// New component for larger animal icons as shown in the screenshot
struct AnimalLevelIconView: View {
    let level: Int
    let animalType: AnimalWelfareLevel.AnimalType
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Animal image based on level and type
            Image(systemName: getAnimalIconName())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(getLevelColor())
                .padding(5)
            
            // Level badge in corner
            ZStack {
                Circle()
                    .fill(getLevelColor())
                    .frame(width: 24, height: 24)
                
                Text("\(level)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
            .offset(x: -5, y: -5)
        }
    }
    
    private func getAnimalIconName() -> String {
        switch animalType {
        case .cow:
            return "hare.fill" // Placeholder, would be a cow icon in real implementation
        case .pig:
            return "pawprint.fill" // Placeholder, would be a pig icon
        case .chicken:
            return "bird.fill" // Placeholder for chicken
        }
    }
    
    private func getLevelColor() -> Color {
        switch level {
        case 5: return Color.level5
        case 4: return Color.level4
        case 3: return Color.level3
        case 2: return Color.level2
        case 1: return Color.level1
        default: return Color.gray
        }
    }
} 
