import Foundation

class AnimalWelfareViewModel: ObservableObject {
    @Published var animalWelfareLevels: [AnimalWelfareLevel] = []
    @Published var selectedAnimalType: AnimalWelfareLevel.AnimalType = .cow
    
    init(animalType: AnimalWelfareLevel.AnimalType = .cow) {
        self.selectedAnimalType = animalType
        loadData()
    }
    
    func loadData() {
        self.animalWelfareLevels = LocalDataService.loadAnimalWelfareLevels()
    }
    
    var filteredLevels: [AnimalWelfareLevel] {
        animalWelfareLevels
            .filter { $0.animalType == selectedAnimalType }
            .sorted { $0.level > $1.level }
    }
    
    func getLevel(id: String) -> AnimalWelfareLevel? {
        return animalWelfareLevels.first { $0.id == id }
    }
    
    func setAnimalType(_ type: AnimalWelfareLevel.AnimalType) {
        self.selectedAnimalType = type
    }
} 