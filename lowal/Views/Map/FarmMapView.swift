import SwiftUI
import MapKit

struct FarmMapView: View {
    @StateObject private var viewModel = FarmMapViewModel()
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.6645, longitude: 9.2058),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                MapViewContent(mapRegion: $mapRegion, viewModel: viewModel)
                SearchAndControlsOverlay(viewModel: viewModel)
                
                if let selectedFarm = viewModel.selectedFarm {
                    FarmSelectionOverlay(farm: selectedFarm, viewModel: viewModel)
                }
            }
            .navigationTitle("Lowal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Map View Content
private struct MapViewContent: View {
    @Binding var mapRegion: MKCoordinateRegion
    @ObservedObject var viewModel: FarmMapViewModel
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: viewModel.filteredFarms) { farm in
            MapAnnotation(coordinate: farm.coordinate) {
                Button(action: {
                    viewModel.selectFarm(farm)
                }) {
                    FarmAnnotationView(farm: farm, viewModel: viewModel)
                }
            }
        }
    }
}

// MARK: - Farm Annotation View
private struct FarmAnnotationView: View {
    let farm: Farm
    @ObservedObject var viewModel: FarmMapViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 44, height: 44)
                    .shadow(radius: 3)
                
                if let imageURL = farm.imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24))
                }
            }
            
            let productBadges = getBadgesForFarm(farm, viewModel: viewModel)
            if !productBadges.isEmpty {
                HStack(spacing: 4) {
                    ForEach(productBadges.prefix(3), id: \.self) { badge in
                        badge
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
            }
        }
    }
}

// MARK: - Search and Controls Overlay
private struct SearchAndControlsOverlay: View {
    @ObservedObject var viewModel: FarmMapViewModel
    
    var body: some View {
        VStack {
            SearchBar(searchText: $viewModel.searchText)
            Spacer()
            BottomControls()
        }
    }
}

// MARK: - Search Bar
private struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search local producers", text: $searchText)
                .disableAutocorrection(true)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding()
    }
}

// MARK: - Bottom Controls
private struct BottomControls: View {
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                // Center map on user location
            }) {
                Image(systemName: "location.fill")
                    .font(.headline)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .shadow(radius: 2)
                    )
            }
        }
        .padding()
    }
}

// MARK: - Farm Selection Overlay
private struct FarmSelectionOverlay: View {
    let farm: Farm
    @ObservedObject var viewModel: FarmMapViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(farm.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.clearSelection()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                Text(farm.description)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    NavigationLink(destination: FarmDetailView(farm: farm)) {
                        Text("View details")
                            .font(.subheadline)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    if let firstProduct = farm.products.first,
                       let co2Reduction = firstProduct.co2Reduction {
                        CO2BadgeView(reduction: co2Reduction)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 4)
            )
            .padding()
        }
    }
}

// MARK: - Helper Functions
private func getBadgesForFarm(_ farm: Farm, viewModel: FarmMapViewModel) -> [LevelBadgeView] {
    var badges: [LevelBadgeView] = []
    
    // Get unique animal levels
    var cowLevel: Int? = nil
    var pigLevel: Int? = nil
    var chickenLevel: Int? = nil
    var plantLevel: Int? = nil
    
    for product in farm.products {
        if let animalLevelID = product.animalWelfareLevelID,
           let animalLevel = viewModel.getAnimalWelfareLevel(for: animalLevelID) {
            
            switch animalLevel.animalType {
            case .cow where cowLevel == nil:
                cowLevel = animalLevel.level
            case .pig where pigLevel == nil:
                pigLevel = animalLevel.level
            case .chicken where chickenLevel == nil:
                chickenLevel = animalLevel.level
            default:
                break
            }
        }
        
        if plantLevel == nil,
           let plantLevelID = product.plantSustainabilityLevelID,
           let sustainability = viewModel.getPlantSustainabilityLevel(for: plantLevelID) {
            plantLevel = sustainability.level
        }
    }
    
    if let cowLevel = cowLevel {
        badges.append(LevelBadgeView(level: cowLevel, category: .cow))
    }
    
    if let pigLevel = pigLevel {
        badges.append(LevelBadgeView(level: pigLevel, category: .pig))
    }
    
    if let chickenLevel = chickenLevel {
        badges.append(LevelBadgeView(level: chickenLevel, category: .chicken))
    }
    
    if let plantLevel = plantLevel {
        badges.append(LevelBadgeView(level: plantLevel, category: .plant))
    }
    
    return badges
} 