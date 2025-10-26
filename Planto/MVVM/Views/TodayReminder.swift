//
//  TodayReminder.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 28/04/1447 AH.
//
import SwiftUI

struct TodayReminder: View {
    @EnvironmentObject var store: PlantStore
    @State private var showAddSheet = false
    @State private var plantToEdit: Plant? = nil
    private var wateredCount: Int {
        store.plants.filter { $0.isWatered }.count
    }
        private var progress: Double {
        guard !store.plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(store.plants.count)
    }
        private var headerMessage: String {
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
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    // MARK: - Header Message
                    VStack(alignment: .leading, spacing: 12) {
                        Text(headerMessage)
                            .font(.system(size: 17))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        // MARK: - Progress Bar
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 361, height: 8)
                                .cornerRadius(8)
                            
                            Rectangle()
                                .fill(Color.greeny)
                                .frame(width: 361 * progress, height: 8)
                                .cornerRadius(8)
                                .animation(.spring(), value: progress)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 8)
                    
                    //Plants List
                    List {
                        ForEach(store.plants) { plant in
                            PlantRowView(plant: plant, onEdit: {
                                plantToEdit = plant
                            })
                            .listRowInsets(EdgeInsets())
                            .environmentObject(store)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deletePlant(plant)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                //Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.greeny)
                                .clipShape(Circle())
                                .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("My Plants 🌱")
        }
        .sheet(isPresented: $showAddSheet) {
            SetReminder()
                .environmentObject(store)
        }
        .sheet(item: $plantToEdit) { plant in
            SetReminder(plantToEdit: plant)
                .environmentObject(store)
        }
    }
    
    //Delete Function
    private func deletePlant(_ plant: Plant) {
        withAnimation {
            store.plants.removeAll { $0.id == plant.id }
        }
    }
}

//Plant Row Component
struct PlantRowView: View {
    @EnvironmentObject var store: PlantStore
    let plant: Plant
    let onEdit: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Checkbox
            Button {
                toggleWatered()
            } label: {
                ZStack {
                    Circle()
                        .stroke(plant.isWatered ? Color.greeny : Color.gray, lineWidth: 2)
                        .frame(width: 23, height: 23)
                    
                    if plant.isWatered {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.greeny)
                    }
                }
            }
            
            // Plant Info
            VStack(alignment: .leading, spacing: 4) {
                // Room
                HStack(spacing: 4) {
                    Image("Location")
                        .resizable()
                        .frame(width: 12, height: 12)
                    Text("in \(plant.room)")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                // Plant Name
                Text(plant.name)
                    .font(.system(size: 28, weight: .semibold))
                
                // Light & Water
                HStack(spacing: 8) {
                    // Light
                    HStack(spacing: 4) {
                        Image("FullSun")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(plant.light)
                            .font(.system(size: 13))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green.opacity(0.5))
                    )
                    
                    // Water Amount
                    HStack(spacing: 4) {
                        Image("Drop")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(plant.waterAmount)
                            .font(.system(size: 13))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.5))
                    )
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onEdit()
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(plant.isWatered ? Color.green.opacity(0.05) : Color.clear)
    }
    
    private func toggleWatered() {
        if let index = store.plants.firstIndex(where: { $0.id == plant.id }) {
            store.plants[index].isWatered.toggle()
        }
    }
}

#Preview {
    TodayReminder()
        .environmentObject(PlantStore())
}
