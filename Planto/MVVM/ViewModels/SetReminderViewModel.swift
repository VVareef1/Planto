//
//  SetReminderViewModel.swift
//  Planto
//
//  MVVM Architecture - Simplified & Clean
//

import SwiftUI
import Combine

class SetReminderViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedRoom = 1
    @Published var selectedLight = 1
    @Published var wateringDays = 1
    @Published var waterAmount = 1
    @Published var plantName = ""
    
    // MARK: - Edit Mode
    private var editingPlant: Plant?
    
    var isEditMode: Bool {
        editingPlant != nil
    }
    
    // MARK: - Validation
    var isValid: Bool {
        !plantName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var errorMessage: String? {
        guard isValid else { return "Please enter a plant name" }
        return nil
    }
    
    // MARK: - Init
    init(plant: Plant? = nil) {
        self.editingPlant = plant
        if let plant = plant {
            loadPlantData(plant)
        }
    }
    
    // MARK: - Load Data
    func loadPlantData(_ plant: Plant) {
        plantName = plant.name
        selectedRoom = getRoomTag(from: plant.room)
        selectedLight = getLightTag(from: plant.light)
        waterAmount = getWaterTag(from: plant.waterAmount)
    }
    
    // MARK: - Create Plant
    func createPlant() -> Plant {
        Plant(
            name: plantName,
            room: getRoomName(from: selectedRoom),
            light: getLightName(from: selectedLight),
            waterAmount: getWaterAmount(from: waterAmount),
            isWatered: false
        )
    }
    
    // MARK: - Save/Update/Delete
    func save(to store: PlantStore, notificationVM: NotificationViewModel) {
        guard isValid else { return }
        
        let plant = createPlant()
        store.plants.append(plant)
        
        // تجريبي: إشعار بعد 15 ثانية
        notificationVM.schedulePlantReminder(plantName: plant.name, after: 15)
    }
    
    func update(in store: PlantStore) {
        guard isValid, let plant = editingPlant,
              let index = store.plants.firstIndex(where: { $0.id == plant.id }) else { return }
        
        store.plants[index].name = plantName
        store.plants[index].room = getRoomName(from: selectedRoom)
        store.plants[index].light = getLightName(from: selectedLight)
        store.plants[index].waterAmount = getWaterAmount(from: waterAmount)
    }
    
    func delete(from store: PlantStore) {
        guard let plant = editingPlant else { return }
        store.plants.removeAll { $0.id == plant.id }
    }
    
    // MARK: - Reset
    func reset() {
        plantName = ""
        selectedRoom = 1
        selectedLight = 1
        wateringDays = 1
        waterAmount = 1
    }
    
    // MARK: - Mapping: Tag ↔ Name
    func getRoomName(from tag: Int) -> String {
        ["", "Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"][safe: tag] ?? "Unknown"
    }
    
    func getLightName(from tag: Int) -> String {
        ["", "Full Sun", "Partial Sun", "Low Light"][safe: tag] ?? "Unknown"
    }
    
    func getWaterAmount(from tag: Int) -> String {
        ["", "20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"][safe: tag] ?? "Unknown"
    }
    
    func getRoomTag(from name: String) -> Int {
        ["Bedroom": 1, "Living Room": 2, "Kitchen": 3, "Balcony": 4, "Bathroom": 5][name] ?? 1
    }
    
    func getLightTag(from name: String) -> Int {
        ["Full Sun": 1, "Partial Sun": 2, "Low Light": 3][name] ?? 1
    }
    
    func getWaterTag(from name: String) -> Int {
        ["20-50 ml": 1, "50-100 ml": 2, "100-200 ml": 3, "200-300 ml": 4][name] ?? 1
    }
}

// MARK: - Array Extension (للأمان)
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
