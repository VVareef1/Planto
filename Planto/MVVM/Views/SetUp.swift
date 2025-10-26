//
//  ContentView.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 24/04/1447 AH.
//
import SwiftUI
import SwiftData

struct SetUp: View {
    @State private var showSheet = false
    @EnvironmentObject var store: PlantStore
    
    var body: some View {
        
        ZStack {
 
            
            VStack {
                VStack(alignment: .leading) {
                    Text("My Plants 🌱")
                        .font(.system(size: 32))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 25)
                        .padding(.leading, 20)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.white.opacity(0.2))
                        .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                
                VStack(spacing: 40) {
                    Image("plant_pot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .shadow(radius: 8)
                        .padding(.top, 40)
                    
                    VStack(spacing: 8) {
                        Text("Start your plant journey!")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :) 🌿")
                            .font(.system(size: 16))
                            .foregroundColor(Color.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                    }
                    
                    GlassEffectContainer {
                        Button(action: {
                            showSheet.toggle()
                        }) {
                            Text("Set Plant Reminder")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.lightGreen)
                                .foregroundColor(.white)
                                .shadow(radius: 6, y: 3)
                                .frame(width: 280, height: 44)
                                .cornerRadius(60)
                        }
                        .glassEffect()
                        .sheet(isPresented: $showSheet) {
                            SetReminder()
                                .environmentObject(store)
                                .ignoresSafeArea()
                        }
                    }

                    }
                    
                    .frame(maxWidth: .infinity, alignment: .center)                    
                    Spacer()
                }
            }
            
        }
    }
    
    
    #Preview {
        SetUp()
            .environmentObject(PlantStore())

    }

