import Foundation

class FarmDetailViewModel: ObservableObject {
    @Published var farm: Farm
    @Published var animalWelfareLevels: [AnimalWelfareLevel] = []
    @Published var plantSustainabilityLevels: [PlantSustainabilityLevel] = []
    
    init(farm: Farm) {
        self.farm = farm
        loadData()
    }
    
    private func loadData() {
        self.animalWelfareLevels = LocalDataService.loadAnimalWelfareLevels()
        self.plantSustainabilityLevels = LocalDataService.loadPlantSustainabilityLevels()
    }
    
    func getAnimalWelfareLevel(for product: Product) -> AnimalWelfareLevel? {
        guard let levelID = product.animalWelfareLevelID else { return nil }
        return animalWelfareLevels.first { $0.id == levelID }
    }
    
    func getPlantSustainabilityLevel(for product: Product) -> PlantSustainabilityLevel? {
        guard let levelID = product.plantSustainabilityLevelID else { return nil }
        return plantSustainabilityLevels.first { $0.id == levelID }
    }
    
    var animalProducts: [Product] {
        farm.products.filter { product in
            [.cow, .pig, .chicken].contains(product.category)
        }
    }
    
    var plantProducts: [Product] {
        farm.products.filter { product in
            [.vegetables, .fruits, .grains].contains(product.category)
        }
    }
    
    var otherProducts: [Product] {
        farm.products.filter { product in
            product.category == .other
        }
    }
} 