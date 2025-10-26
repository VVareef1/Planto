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
    
    // طلب الإذن للإشعارات
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print(granted ? "✅ الإشعارات مسموح بها" : "❌ الإشعارات مرفوضة")
        }
    }
    
    // إشعار ترحيبي بسيط عند فتح التطبيق
    func sendWelcomeNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Planto 🌿"
        content.body = "مرحبًا بك! لا تنسَ سقي نباتك اليوم 💧"
        content.sound = .default
        
        // بعد 3 ثواني من فتح التطبيق
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // إشعار تذكير لتجارب سريعة (بالثواني)
    func schedulePlantReminder(plantName: String, after seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "💧 تذكير بالسقي"
        content.body = "حان وقت سقي \(plantName) 🌿"
        content.sound = .default

        // يرسل الإشعار بعد عدد الثواني المحددة
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ خطأ في جدولة إشعار \(plantName): \(error.localizedDescription)")
            } else {
                print("✅ تم جدولة تذكير سقي \(plantName) بعد \(seconds) ثانية")
            }
        }
    }
}


