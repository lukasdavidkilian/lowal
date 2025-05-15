import Foundation

class PlantLevelViewModel: ObservableObject {
    @Published var plantSustainabilityLevels: [PlantSustainabilityLevel] = []
    @Published var selectedPlantCategory: PlantSustainabilityLevel.PlantCategory?
    
    init(plantCategory: PlantSustainabilityLevel.PlantCategory? = nil) {
        self.selectedPlantCategory = plantCategory
        loadData()
    }
    
    func loadData() {
        self.plantSustainabilityLevels = LocalDataService.loadPlantSustainabilityLevels()
    }
    
    var filteredLevels: [PlantSustainabilityLevel] {
        if let category = selectedPlantCategory {
            return plantSustainabilityLevels
                .filter { $0.plantCategory == category }
                .sorted { $0.level > $1.level }
        } else {
            // For the generic "All Plants" view, show only generic levels
            return plantSustainabilityLevels
                .filter { $0.plantCategory == nil }
                .sorted { $0.level > $1.level }
        }
    }
    
    func getLevel(id: String) -> PlantSustainabilityLevel? {
        return plantSustainabilityLevels.first { $0.id == id }
    }
    
    func setPlantCategory(_ category: PlantSustainabilityLevel.PlantCategory?) {
        self.selectedPlantCategory = category
    }
} 