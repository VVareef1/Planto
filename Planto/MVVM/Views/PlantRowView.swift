//
//  PlantRowView.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 04/05/1447 AH.


import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    let onToggle: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Checkbox
            Button(action: onToggle) {
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
                HStack(spacing: 4) {
                    Image("Location")
                        .resizable()
                        .frame(width: 12, height: 12)
                    Text("in \(plant.room)")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Text(plant.name)
                    .font(.system(size: 28, weight: .semibold))
                
                HStack(spacing: 8) {
                    tagView(icon: "FullSun", text: plant.light, color: .green)
                    tagView(icon: "Drop", text: plant.waterAmount, color: .gray)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture(perform: onEdit)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(plant.isWatered ? Color.green.opacity(0.05) : Color.clear)
    }
    
    private func tagView(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Image(icon)
                .resizable()
                .frame(width: 12, height: 12)
            Text(text)
                .font(.system(size: 13))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.5)))
    }
}
