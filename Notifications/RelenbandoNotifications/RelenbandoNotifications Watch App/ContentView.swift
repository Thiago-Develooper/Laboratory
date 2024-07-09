//
//  ContentView.swift
//  RelenbandoNotifications Watch App
//
//  Created by Thiago Pereira de Menezes on 17/05/24.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (sucess, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotifications() {
        let content = UNMutableNotificationContent()
        
        content.title = "This is my first notification!"
        content.subtitle = "This was sooooo easy!"
        content.sound = .default
        content.badge = 1
        
        // time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
        // location
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedrule notification") {
                NotificationManager.instance.scheduleNotifications()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
