import SwiftUI

struct SetUp: View {
    @State private var showSheet = false
    @EnvironmentObject var store: PlantStore
    @StateObject private var notificationVM = NotificationViewModel()  // ← هذا السطر جديد
    
    var body: some View {
        Group {
            if store.plants.isEmpty {
                WelcomeView(showSheet: $showSheet)
                    .environmentObject(store)
            } else {
                TodayReminder()
                    .environmentObject(store)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: store.plants.isEmpty)
        .onAppear {
            notificationVM.requestPermission()  // ← هذا السطر جديد
        }
    }
}

// MARK: - Welcome View
struct WelcomeView: View {
    @Binding var showSheet: Bool
    @EnvironmentObject var store: PlantStore
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
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
                    
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Text("Set Plant Reminder")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(width: 280, height: 44)
                            .background(Color.lightGreen)
                            .foregroundColor(.white)
                            .cornerRadius(60)
                            .shadow(radius: 6, y: 3)
                    }
                    .sheet(isPresented: $showSheet) {
                        SetReminder()
                            .environmentObject(store)
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
