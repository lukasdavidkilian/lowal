import Foundation

struct PlantSustainabilityLevel: Identifiable, Codable {
    var id: String
    var level: Int
    var title: String
    var description: String
    var keyCharacteristics: [String]
    var plantCategory: PlantCategory?
    
    enum PlantCategory: String, Codable {
        case vegetables
        case fruits
        case grains
    }
} 