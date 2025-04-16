import SwiftUI

struct PlantLevelListView: View {
    @StateObject private var viewModel: PlantLevelViewModel
    
    init(plantCategory: PlantSustainabilityLevel.PlantCategory? = nil) {
        self._viewModel = StateObject(wrappedValue: PlantLevelViewModel(plantCategory: plantCategory))
    }
    
    var body: some View {
        List {
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
            
            Section {
                Text("This overview simplifies complex practices to make them easier to understand. It's not perfect, but it's a starting point.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            }
            
            ForEach(viewModel.filteredLevels) { level in
                NavigationLink(destination: PlantLevelDetailView(level: level)) {
                    HStack(spacing: 16) {
                        LevelBadgeView(level: level.level, category: .plant)
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(level.level)")
                                    .font(.headline)
                                Text(level.title)
                                    .font(.headline)
                            }
                            
                            Text(level.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Plant Sustainability Levels")
        .navigationBarTitleDisplayMode(.inline)
    }
}