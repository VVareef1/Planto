//
//  SetReminder.swift
//  Planto
//
//  MVVM Architecture - Clean View
//

import SwiftUI

struct SetReminder: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: PlantStore
    @StateObject private var notificationVM = NotificationViewModel()
    @StateObject private var viewModel: SetReminderViewModel
    
    @State private var showDeleteConfirmation = false
    
    init(plantToEdit: Plant? = nil) {
        _viewModel = StateObject(wrappedValue: SetReminderViewModel(plant: plantToEdit))
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
                    if viewModel.isEditMode {
                        viewModel.update(in: store)
                    } else {
                        viewModel.save(to: store, notificationVM: notificationVM)
                    }
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.lightGreen)
                        .clipShape(Circle())
                }
                .disabled(!viewModel.isValid)
                .opacity(viewModel.isValid ? 1.0 : 0.5)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // MARK: - Form
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $viewModel.plantName)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    HStack {
                        Image("Location")
                            .frame(width: 15, height: 15)
                        Picker(selection: $viewModel.selectedRoom, label: Text("Room")) {
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
                        Picker(selection: $viewModel.selectedLight, label: Text("Light")) {
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
                        Picker(selection: $viewModel.wateringDays, label: Text("Watering Days")) {
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
                        Picker(selection: $viewModel.waterAmount, label: Text("Water")) {
                            Text("20-50 ml").tag(1)
                            Text("50-100 ml").tag(2)
                            Text("100-200 ml").tag(3)
                            Text("200-300 ml").tag(4)
                        }
                    }
                }
            }
            
            // MARK: - Delete Button
            if viewModel.isEditMode {
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
        .alert("Delete Plant?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.delete(from: store)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \(viewModel.plantName)?")
        }
    }
}

#Preview {
    SetReminder()
        .environmentObject(PlantStore())
}
