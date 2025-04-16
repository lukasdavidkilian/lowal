import Foundation

class LocalDataService {
    
    static func loadFarms() -> [Farm] {
        guard let data = loadJSONFile(named: "farms") else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Farm].self, from: data)
        } catch {
            print("Error decoding farms: \(error)")
            return []
        }
    }
    
    static func loadAnimalWelfareLevels() -> [AnimalWelfareLevel] {
        guard let data = loadJSONFile(named: "animalWelfareLevels") else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([AnimalWelfareLevel].self, from: data)
        } catch {
            print("Error decoding animal welfare levels: \(error)")
            return []
        }
    }
    
    static func loadPlantSustainabilityLevels() -> [PlantSustainabilityLevel] {
        guard let data = loadJSONFile(named: "plantSustainabilityLevels") else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([PlantSustainabilityLevel].self, from: data)
        } catch {
            print("Error decoding plant sustainability levels: \(error)")
            return []
        }
    }
    
    private static func loadJSONFile(named filename: String) -> Data? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            print("Could not find \(filename).json in bundle")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            print("Error loading \(filename).json: \(error)")
            return nil
        }
    }
} 