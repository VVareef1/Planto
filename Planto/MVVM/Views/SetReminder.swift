import SwiftUI
import SwiftData

struct SetReminder: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: PlantStore
    @StateObject private var notificationVM = NotificationViewModel()
    
    // MARK: - Edit Mode Support (جديد)
    let plantToEdit: Plant?
    
    @State private var selectedRoom = 1
    @State private var selectedLight = 1
    @State private var watringDays = 1
    @State private var waterAmount = 1
    @State private var plantName = String()
    @State private var showDeleteConfirmation = false
    
    // Validation
    private var isValid: Bool {
        !plantName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    // Check if editing
    private var isEditMode: Bool {
        plantToEdit != nil
    }
    
    // MARK: - Init (جديد)
    init(plantToEdit: Plant? = nil) {
        self.plantToEdit = plantToEdit
    }
    
    var body: some View {
        VStack {
            // MARK: - Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button {
                    if isEditMode {
                        updatePlant()
                    } else {
                        savePlant()
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.lightGreen)
                        .clipShape(Circle())
                }
                .disabled(!isValid)
                .opacity(isValid ? 1.0 : 0.5)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // MARK: - Form
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    HStack {
                        Image("Location")
                            .frame(width: 15, height: 15)
                        Picker(selection: $selectedRoom, label: Text("Room")) {
                            Text("Bedroom").tag(1)
                            Text("Living Room").tag(2)
                            Text("Kitchen").tag(3)
                            Text("Balcony").tag(4)
                            Text("Bathroom").tag(5)
                        }
                    }
                    
                    HStack {
                        Image("FullSun")
                            .frame(width: 15, height: 15)
                        Picker(selection: $selectedLight, label: Text("Light")) {
                            Text("Full Sun").tag(1)
                            Text("Partial Sun").tag(2)
                            Text("Low Light").tag(3)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Image("Drop")
                            .frame(width: 15, height: 15)
                        Picker(selection: $watringDays, label: Text("Watering Days")) {
                            Text("Every day").tag(1)
                            Text("Every 2 days").tag(2)
                            Text("Every 3 days").tag(3)
                            Text("Once a month").tag(4)
                            Text("Every 10 days").tag(5)
                            Text("Every 20 days").tag(6)
                        }
                    }
                    
                    HStack {
                        Image("Drop")
                            .frame(width: 15, height: 15)
                        Picker(selection: $waterAmount, label: Text("Water")) {
                            Text("20-50 ml").tag(1)
                            Text("50-100 ml").tag(2)
                            Text("100-200 ml").tag(3)
                            Text("200-300 ml").tag(4)
                        }
                    }
                }
            }
            
            // MARK: - Delete Button (only in Edit Mode)
            if isEditMode {
                Button {
                    showDeleteConfirmation = true
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 320, height: 52)
                            .cornerRadius(37)
                        
                        Text("Delete Reminder")
                            .foregroundColor(Color.red.opacity(0.7))
                    }
                }
                .padding(.bottom, 10)
            }
        }
        .onAppear {
            loadPlantData()
        }
        .alert("Delete Plant?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deletePlant()
            }
        } message: {
            Text("Are you sure you want to delete \(plantName)?")
        }
    }
    
    // MARK: - Load Data (جديد)
    private func loadPlantData() {
        guard let plant = plantToEdit else { return }
        
        plantName = plant.name
        selectedRoom = getRoomTag(from: plant.room)
        selectedLight = getLightTag(from: plant.light)
        waterAmount = getWaterTag(from: plant.waterAmount)
    }
    
    // MARK: - Save New Plant
    private func savePlant() {
        guard isValid else { return }
        
        let newPlant = Plant(
            name: plantName,
            room: getRoomName(from: selectedRoom),
            light: getLightName(from: selectedLight),
            waterAmount: getWaterAmount(from: waterAmount),
            isWatered: false
        )
        
        store.plants.append(newPlant)
        
        let delay = getNotificationDelay()
        notificationVM.schedulePlantReminder(plantName: newPlant.name, after: delay)
        
        dismiss()
    }
    
    // MARK: - Update Plant (جديد)
    private func updatePlant() {
        guard isValid, let plant = plantToEdit else { return }
        guard let index = store.plants.firstIndex(where: { $0.id == plant.id }) else { return }
        
        store.plants[index].name = plantName
        store.plants[index].room = getRoomName(from: selectedRoom)
        store.plants[index].light = getLightName(from: selectedLight)
        store.plants[index].waterAmount = getWaterAmount(from: waterAmount)
        
        dismiss()
    }
    
    // MARK: - Delete Plant (جديد)
    private func deletePlant() {
        guard let plant = plantToEdit else { return }
        store.plants.removeAll { $0.id == plant.id }
        dismiss()
    }
    
    // MARK: - Helpers
    private func getNotificationDelay() -> Double {
        switch watringDays {
        case 1: return 86400
        case 2: return 172800
        case 3: return 259200
        case 4: return 2592000
        case 5: return 864000
        case 6: return 1728000
        default: return 86400
        }
    }
    
    private func getRoomTag(from name: String) -> Int {
        switch name {
        case "Bedroom": return 1
        case "Living Room": return 2
        case "Kitchen": return 3
        case "Balcony": return 4
        case "Bathroom": return 5
        default: return 1
        }
    }
    
    private func getLightTag(from name: String) -> Int {
        switch name {
        case "Full Sun": return 1
        case "Partial Sun": return 2
        case "Low Light": return 3
        default: return 1
        }
    }
    
    private func getWaterTag(from name: String) -> Int {
        switch name {
        case "20-50 ml": return 1
        case "50-100 ml": return 2
        case "100-200 ml": return 3
        case "200-300 ml": return 4
        default: return 1
        }
    }
}

func getRoomName(from tag: Int) -> String {
    switch tag {
    case 1: return "Bedroom"
    case 2: return "Living Room"
    case 3: return "Kitchen"
    case 4: return "Balcony"
    case 5: return "Bathroom"
    default: return ""
    }
}

func getLightName(from tag: Int) -> String {
    switch tag {
    case 1: return "Full Sun"
    case 2: return "Partial Sun"
    case 3: return "Low Light"
    default: return ""
    }
}

func getWaterAmount(from tag: Int) -> String {
    switch tag {
    case 1: return "20-50 ml"
    case 2: return "50-100 ml"
    case 3: return "100-200 ml"
    case 4: return "200-300 ml"
    default: return ""
    }
}

#Preview {
    SetReminder()
        .environmentObject(PlantStore())
}
