//
//  SetReminder.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 28/04/1447 AH.
//
import SwiftUI
import SwiftData

struct SetReminder: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: PlantStore
    
    @State private var navigateToToday = false
    @State private var selectedRoom = 1
    @State private var selectedLight = 1
    @State private var watringDays = 1
    @State private var waterAmount = 1
    @State private var plantName = String()
    
    var body: some View {
        VStack {
            
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
       
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 10)
            
            Button("Done") {

                let newPlant = Plant(
                    name: plantName.isEmpty ? "Unnamed Plant" : plantName,
                    room: getRoomName(from: selectedRoom),
                    light: getLightName(from: selectedLight),
                    waterAmount: getWaterAmount(from: waterAmount),
                    isWatered: false
                )
                store.plants.append(newPlant)
                dismiss()
            }
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.green)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
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
                            Text("Patrial Sun").tag(2)
                            Text("Low Light").tag(3)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Image("Drop")
                            .frame(width: 15, height: 15)
                        Picker(selection: $watringDays, label: Text("Watring Days")) {
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
            Button {
                dismiss()
                
            } label: {
                ZStack{
                    Text("Delete Reminder")
                        .foregroundColor(Color.red.opacity(0.7))
                    Rectangle()
                        .fill(Color.gray
                            .opacity(0.1))
                        .frame(width: 320, height: 52)
                        .cornerRadius(37)
                    
                    
                    Spacer()
                }

            }
            .scrollContentBackground(.hidden)
        
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
