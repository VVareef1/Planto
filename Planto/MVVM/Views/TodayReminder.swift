//
//  TodayReminder.swift
//  Planto
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
    
    private var allPlantsWatered: Bool {
        !store.plants.isEmpty && store.plants.allSatisfy { $0.isWatered }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if allPlantsWatered {
                    AllDoneView()
                } else {
                    mainContent
                }
                addButton
            }
            .navigationTitle("My Plants 🌱")
        }
        .sheet(isPresented: $showAddSheet) {
            SetReminder().environmentObject(store)
        }
        .sheet(item: $plantToEdit) { plant in
            SetReminder(plantToEdit: plant).environmentObject(store)
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            headerSection
            plantsList
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(headerMessage)
                .font(.system(size: 17))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            progressBar
        }
        .padding(.top, 8)
    }
    
    private var progressBar: some View {
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
    
    private var plantsList: some View {
        List {
            ForEach(store.plants) { plant in
                PlantRowView(
                    plant: plant,
                    onToggle: { toggleWatered(plant: plant) },
                    onEdit: { plantToEdit = plant }
                )
                .listRowInsets(EdgeInsets())
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
    
    private var addButton: some View {
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
    
    // MARK: - Actions
    private func toggleWatered(plant: Plant) {
        guard let index = store.plants.firstIndex(where: { $0.id == plant.id }) else { return }
        store.plants[index].isWatered.toggle()
    }
    
    private func deletePlant(_ plant: Plant) {
        print("🗑️ حذف نبتة: \(plant.name)")
        print("📊 قبل الحذف: \(store.plants.count) نباتات")
        
        withAnimation {
            store.plants.removeAll { $0.id == plant.id }
        }
        
        print("📊 بعد الحذف: \(store.plants.count) نباتات")
        print("📋 النباتات المتبقية: \(store.plants.map { $0.name })")
    }
}

#Preview {
    TodayReminder()
        .environmentObject(PlantStore())
}
