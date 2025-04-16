import SwiftUI

struct AnimalWelfareListView: View {
    @StateObject private var viewModel: AnimalWelfareViewModel
    
    init(animalType: AnimalWelfareLevel.AnimalType = .cow) {
        self._viewModel = StateObject(wrappedValue: AnimalWelfareViewModel(animalType: animalType))
    }
    
    var body: some View {
        List {
            Section {
                Picker("Animal Type", selection: $viewModel.selectedAnimalType) {
                    Text("Cow").tag(AnimalWelfareLevel.AnimalType.cow)
                    Text("Pig").tag(AnimalWelfareLevel.AnimalType.pig)
                    Text("Chicken").tag(AnimalWelfareLevel.AnimalType.chicken)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 8)
            }
            
            Section {
                Text("This overview simplifies complex practices to make them easier to understand. It's not perfect, but it's a starting point.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            }
            
            ForEach(viewModel.filteredLevels) { level in
                NavigationLink(destination: AnimalWelfareDetailView(level: level)) {
                    HStack(spacing: 16) {
                        LevelBadgeView(level: level.level, category: getCategoryBadge(for: viewModel.selectedAnimalType))
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(level.level)")
                                    .font(.headline)
                                Text(level.title)
                                    .font(.headline)
                            }
                            
                            Text(level.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Animal Welfare Levels")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getCategoryBadge(for animalType: AnimalWelfareLevel.AnimalType) -> LevelBadgeView.BadgeCategory {
        switch animalType {
        case .cow: return .cow
        case .pig: return .pig
        case .chicken: return .chicken
        }
    }
} 
