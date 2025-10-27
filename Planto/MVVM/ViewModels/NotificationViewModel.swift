//
//  Untitled.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 04/05/1447 AH.
//
import Foundation
import UserNotifications
import Combine

class NotificationViewModel: ObservableObject {
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print(granted ? "✅ Notifications allowed" : "❌ Notifications denied")
        }
    }
    
    func sendWelcomeNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Planto 🌿"
        content.body = "Welcome! Don't forget to water your plant today 💧"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func schedulePlantReminder(plantName: String, after seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "💧 Watering Reminder"
        content.body = "It's time to water me! \(plantName) 🌿"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Error scheduling notification for \(plantName): \(error.localizedDescription)")
            } else {
                print("✅ Watering reminder for \(plantName) scheduled after \(seconds) seconds")
            }
        }
    }
}
