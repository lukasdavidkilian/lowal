import SwiftUI

struct PlantLevelListView: View {
    @StateObject private var viewModel: PlantLevelViewModel
    @State private var showPlantCategoryPicker = false
    
    init(plantCategory: PlantSustainabilityLevel.PlantCategory? = nil) {
        self._viewModel = StateObject(wrappedValue: PlantLevelViewModel(plantCategory: plantCategory))
    }
    
    var body: some View {
        List {
            // Plant category picker is hidden by default now that we have a dedicated overview screen
            if showPlantCategoryPicker {
                Section {
                    Picker("Plant Category", selection: $viewModel.selectedPlantCategory) {
                        Text("All").tag(nil as PlantSustainabilityLevel.PlantCategory?)
                        Text("Vegetables").tag(PlantSustainabilityLevel.PlantCategory.vegetables as PlantSustainabilityLevel.PlantCategory?)
                        Text("Fruits").tag(PlantSustainabilityLevel.PlantCategory.fruits as PlantSustainabilityLevel.PlantCategory?)
                        Text("Grains").tag(PlantSustainabilityLevel.PlantCategory.grains as PlantSustainabilityLevel.PlantCategory?)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8)
                }
            }
            
            ForEach(viewModel.filteredLevels) { level in
                NavigationLink(destination: PlantLevelDetailView(level: level)) {
                    HStack(spacing: 16) {
                        PlantLevelIconView(level: level.level, plantCategory: viewModel.selectedPlantCategory)
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
        if let category = viewModel.selectedPlantCategory {
            switch category {
            case .vegetables:
                return "Vegetable sustainability levels"
            case .fruits:
                return "Fruit sustainability levels"
            case .grains:
                return "Grain sustainability levels"
            }
        } else {
            return "Plant sustainability levels"
        }
    }
}

// Plant level icon view similar to AnimalLevelIconView
struct PlantLevelIconView: View {
    let level: Int
    let plantCategory: PlantSustainabilityLevel.PlantCategory?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Plant image based on level and category
            Image(systemName: getPlantIconName())
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
    
    private func getPlantIconName() -> String {
        if let category = plantCategory {
            switch category {
            case .vegetables:
                return "carrot.fill" // Using 'carrot' for vegetables
            case .fruits:
                return "apple.logo" // Using 'apple' for fruits
            case .grains:
                return "wheat" // Using 'wheat' for grains
            }
        } else {
            return "leaf.fill" // Default plant icon
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