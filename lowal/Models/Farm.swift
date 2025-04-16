import Foundation
import CoreLocation

struct Farm: Identifiable, Codable {
    var id: String
    var name: String
    var description: String
    var imageURL: String?
    var latitude: Double
    var longitude: Double
    var products: [Product]
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, imageURL, latitude, longitude, products
    }
} 