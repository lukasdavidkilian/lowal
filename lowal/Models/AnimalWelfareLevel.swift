import Foundation

struct AnimalWelfareLevel: Identifiable, Codable {
    var id: String
    var level: Int
    var title: String
    var description: String
    var keyCharacteristics: [String]
    var animalType: AnimalType
    
    enum AnimalType: String, Codable {
        case cow
        case pig
        case chicken
    }
} 