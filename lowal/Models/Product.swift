import Foundation

struct Product: Identifiable, Codable {
    var id: String
    var name: String
    var price: Double
    var unit: String
    var co2Reduction: Int?
    var animalWelfareLevelID: String?
    var plantSustainabilityLevelID: String?
    var category: ProductCategory
    
    enum ProductCategory: String, Codable {
        case cow
        case pig
        case chicken
        case vegetables
        case fruits
        case grains
        case other
    }
} 