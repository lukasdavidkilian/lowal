import SwiftUI

struct AnimalWelfareListView: View {
    @StateObject private var viewModel: AnimalWelfareViewModel
    @State private var showAnimalTypePicker = false
    
    init(animalType: AnimalWelfareLevel.AnimalType = .cow) {
        self._viewModel = StateObject(wrappedValue: AnimalWelfareViewModel(animalType: animalType))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Animal type picker is hidden by default now that we have a dedicated overview screen
                if showAnimalTypePicker {
                    Picker("Animal Type", selection: $viewModel.selectedAnimalType) {
                        Text("Cow").tag(AnimalWelfareLevel.AnimalType.cow)
                        Text("Pig").tag(AnimalWelfareLevel.AnimalType.pig)
                        Text("Chicken").tag(AnimalWelfareLevel.AnimalType.chicken)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8)
                }
                
                // Animal welfare level cards
                ForEach(viewModel.filteredLevels) { level in
                    NavigationLink(destination: AnimalWelfareDetailView(level: level)) {
                        LevelCardView(
                            level: level.level,
                            title: level.title,
                            description: level.description,
                            type: .animal(mapAnimalType(level.animalType))
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Text("This overview simplifies complex practices to make them easier to understand. It's not perfect, but it's a starting point.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
        }
        .background(Color.white)
        .navigationTitle(getNavigationTitle())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getNavigationTitle() -> String {
        switch viewModel.selectedAnimalType {
        case .cow:
            return "Cow welfare levels"
        case .pig:
            return "Pig welfare levels"
        case .chicken:
            return "Chicken welfare levels"
        }
    }
    
    // Helper function to map from model animal type to LevelCardView animal type
    private func mapAnimalType(_ type: AnimalWelfareLevel.AnimalType) -> LevelCardView.AnimalType {
        switch type {
        case .cow: return .cow
        case .pig: return .pig
        case .chicken: return .chicken
        }
    }
}

// We're now using the shared LevelCardView, so this component can be removed
// struct AnimalLevelIconView: View { ... } 
