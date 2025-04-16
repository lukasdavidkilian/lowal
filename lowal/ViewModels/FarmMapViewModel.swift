import Foundation
import Combine
import CoreLocation

class FarmMapViewModel: ObservableObject {
    @Published var farms: [Farm] = []
    @Published var selectedFarm: Farm?
    @Published var region = CLLocationCoordinate2D(latitude: 47.6645, longitude: 9.2058) // Weingarten am Bodensee
    @Published var searchText: String = ""
    
    private var animalWelfareLevels: [AnimalWelfareLevel] = []
    private var plantSustainabilityLevels: [PlantSustainabilityLevel] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.farms = LocalDataService.loadFarms()
        self.animalWelfareLevels = LocalDataService.loadAnimalWelfareLevels()
        self.plantSustainabilityLevels = LocalDataService.loadPlantSustainabilityLevels()
    }
    
    func selectFarm(_ farm: Farm) {
        self.selectedFarm = farm
    }
    
    func clearSelection() {
        self.selectedFarm = nil
    }
    
    func getAnimalWelfareLevel(for id: String) -> AnimalWelfareLevel? {
        return animalWelfareLevels.first { $0.id == id }
    }
    
    func getPlantSustainabilityLevel(for id: String) -> PlantSustainabilityLevel? {
        return plantSustainabilityLevels.first { $0.id == id }
    }
    
    var filteredFarms: [Farm] {
        if searchText.isEmpty {
            return farms
        } else {
            return farms.filter { farm in
                farm.name.localizedCaseInsensitiveContains(searchText) ||
                farm.description.localizedCaseInsensitiveContains(searchText) ||
                farm.products.contains { product in
                    product.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
} 