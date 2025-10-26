//
//  Untitled.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 04/05/1447 AH.
//

//
//  TodayReminderViewModel.swift
//  Planto
//
//  MVVM Architecture
//

import SwiftUI
import Combine

class TodayReminderViewModel: ObservableObject {
    @Published var store: PlantStore
    
    init(store: PlantStore) {
        self.store = store
    }
    
    // MARK: - Computed Properties
    var wateredCount: Int {
        store.plants.filter { $0.isWatered }.count
    }
    
    var progress: Double {
        guard !store.plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(store.plants.count)
    }
    
    var headerMessage: String {
        if store.plants.isEmpty {
            return "Add your first plant 🌱"
        } else if wateredCount == 0 {
            return "Your plants are waiting for a sip 💧"
        } else if wateredCount == store.plants.count {
            return "All plants feel loved today! ✨"
        } else {
            return "\(wateredCount) of your plants feel loved today ✨"
        }
    }
    
    // MARK: - Actions
    func toggleWatered(plant: Plant) {
        guard let index = store.plants.firstIndex(where: { $0.id == plant.id }) else { return }
        store.plants[index].isWatered.toggle()
    }
    
    func deletePlant(_ plant: Plant) {
        withAnimation {
            store.plants.removeAll { $0.id == plant.id }
        }
    }
}
