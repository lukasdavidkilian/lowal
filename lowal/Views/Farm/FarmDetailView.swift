import SwiftUI

struct FarmDetailView: View {
    @StateObject private var viewModel: FarmDetailViewModel
    
    init(farm: Farm) {
        self._viewModel = StateObject(wrappedValue: FarmDetailViewModel(farm: farm))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Hero image
                if let imageURL = viewModel.farm.imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                    }
                    .frame(height: 200)
                    .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Bio section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bio")
                            .font(.headline)
                        
                        Text(viewModel.farm.description)
                            .font(.body)
                    }
                    
                    Divider()
                    
                    // Products section
                    productsSection(title: "Products", products: viewModel.farm.products)
                    
                    if !viewModel.animalProducts.isEmpty {
                        Divider()
                        productsSection(title: "Animal Products", products: viewModel.animalProducts)
                    }
                    
                    if !viewModel.plantProducts.isEmpty {
                        Divider()
                        productsSection(title: "Plant Products", products: viewModel.plantProducts)
                    }
                    
                    if !viewModel.otherProducts.isEmpty {
                        Divider()
                        productsSection(title: "Other Products", products: viewModel.otherProducts)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.farm.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func productsSection(title: String, products: [Product]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            
            ForEach(products) { product in
                HStack {
                    CategoryIcon(category: product.category)
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.name)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(String(format: "%.2f", product.price)) € / \(product.unit)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 4) {
                            if let animalLevelID = product.animalWelfareLevelID,
                               let animalLevel = viewModel.getAnimalWelfareLevel(for: product) {
                                NavigationLink(destination: AnimalWelfareDetailView(level: animalLevel)) {
                                    LevelBadgeView(level: animalLevel.level, category: getCategoryBadge(for: animalLevel.animalType))
                                }
                            }
                            
                            if let plantLevelID = product.plantSustainabilityLevelID,
                               let plantLevel = viewModel.getPlantSustainabilityLevel(for: product) {
                                NavigationLink(destination: PlantLevelDetailView(level: plantLevel)) {
                                    LevelBadgeView(level: plantLevel.level, category: .plant)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
            }
        }
    }
    
    private func getCategoryBadge(for animalType: AnimalWelfareLevel.AnimalType) -> LevelBadgeView.BadgeCategory {
        switch animalType {
        case .cow: return .cow
        case .pig: return .pig
        case .chicken: return .chicken
        }
    }
} 