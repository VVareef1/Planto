//
//  AllDoneView.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 04/05/1447 AH.
//
//
//  AllDoneView.swift
//  Planto
//
//  Celebration Screen
//

import SwiftUI

struct AllDoneView: View {
    @State private var isWinking = false
    @State private var scale: CGFloat = 0.8
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Plant Image with Animation
                Image("Blink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .scaleEffect(scale)
                    .onAppear {
                        // Bounce Animation
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.5).repeatForever(autoreverses: true)) {
                            scale = 1.0
                        }
                        
                        // Winking Animation
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isWinking = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isWinking = false
                                }
                            }
                        }
                    }
                
                // Title
                Text("All Done! 🎉")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                // Subtitle
                Text("All Reminders Completed")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    AllDoneView()
}
