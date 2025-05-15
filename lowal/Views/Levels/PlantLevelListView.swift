import SwiftUI

struct PlantLevelListView: View {
    @StateObject private var viewModel: PlantLevelViewModel
    @State private var showPlantCategoryPicker = false
    
    init(plantCategory: PlantSustainabilityLevel.PlantCategory? = nil) {
        self._viewModel = StateObject(wrappedValue: PlantLevelViewModel(plantCategory: plantCategory))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Plant category picker is hidden by default now that we have a dedicated overview screen
                if showPlantCategoryPicker {
                    Picker("Plant Category", selection: $viewModel.selectedPlantCategory) {
                        Text("All").tag(nil as PlantSustainabilityLevel.PlantCategory?)
                        Text("Vegetables").tag(PlantSustainabilityLevel.PlantCategory.vegetables as PlantSustainabilityLevel.PlantCategory?)
                        Text("Fruits").tag(PlantSustainabilityLevel.PlantCategory.fruits as PlantSustainabilityLevel.PlantCategory?)
                        Text("Grains").tag(PlantSustainabilityLevel.PlantCategory.grains as PlantSustainabilityLevel.PlantCategory?)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8)
                }
                
                // Plant sustainability level cards
                ForEach(viewModel.filteredLevels) { level in
                    NavigationLink(destination: PlantLevelDetailView(level: level)) {
                        LevelCardView(
                            level: level.level,
                            title: level.title,
                            description: level.description,
                            type: .plant(mapPlantCategory(level.plantCategory))
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Text("This overview simplifies complex practices to make them easier to understand. It's not perfect, but it's a starting point.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
        }
        .background(Color.white)
        .navigationTitle(getNavigationTitle())
        .navigationBarTitleDisplayMode(.inline)
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
    
    // Helper function to map from model plant category to LevelCardView plant category
    private func mapPlantCategory(_ category: PlantSustainabilityLevel.PlantCategory?) -> LevelCardView.PlantCategory? {
        guard let category = category else { return nil }
        
        switch category {
        case .vegetables: return .vegetables
        case .fruits: return .fruits
        case .grains: return .grains
        }
    }
}

// We're now using the shared LevelCardView, so this component can be removed
// struct PlantLevelIconView: View { ... }