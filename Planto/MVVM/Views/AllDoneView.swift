//
//  AllDoneView.swift
//  Planto
//
//

import SwiftUI

struct AllDoneView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image("Blink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 184, height: 200)
                
                Text("All Done! 🎉")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("All Reminders Completed")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    AllDoneView()
}
