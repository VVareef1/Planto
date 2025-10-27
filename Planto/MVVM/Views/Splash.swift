//
//  Splash.swift
//  Planto
//

import SwiftUI
import AVKit

struct Splash: View {
    @State private var isActive = false
    @State private var player: AVPlayer?
    @EnvironmentObject var store: PlantStore  
    
    var body: some View {
        ZStack {
            if isActive {
                SetUp()
                    .environmentObject(store)
            } else {
                splashContent
            }
        }
    }
    
    var splashContent: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if let player = player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .disabled(true)
            } else {
            
            }
            
            VStack {
                Spacer()
                Text("Planto 🌱")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.bottom, 200)
            }
        }
        .onAppear {
            startVideo()
        }
    }
    
    func startVideo() {
        print("🎬 Start")
        
        let possibleNames = ["plant_animation", "plant_animation", "plantAnimation", "Splash"]
        var foundURL: URL?
        
        for name in possibleNames {
            if let url = Bundle.main.url(forResource: name, withExtension: "mp4") {
                print(" Video found \(name).mp4")
                foundURL = url
                break
            }
        }
        
        guard let url = foundURL else {
            print("video don't play \(possibleNames)")
            print("Video played ")
            if let resourcePath = Bundle.main.resourcePath {
                let files = (try? FileManager.default.contentsOfDirectory(atPath: resourcePath)) ?? []
                let videoFiles = files.filter { $0.hasSuffix(".mp4") || $0.hasSuffix(".mov") }
                print(" Resurces \(videoFiles)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    isActive = true
                }
            }
            return
        }
        
        player = AVPlayer(url: url)
        player?.play()
        print("Played")
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { _ in
            print("Video End")
            withAnimation {
                isActive = true
            }
        }
        
        // خطة احتياطية
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            if !isActive {
                print("Video Ends go to main page")
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    Splash()
        .environmentObject(PlantStore())
}
