//
//  SHUApp.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import SwiftUI
import UserNotifications

@main
struct SHUApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//AppDelegate 생성
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // 알림이 화면에 표시될 때 호출됨 (앱이 포그라운드에 있을 때)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림이 사용자에게 표시될 때 scheduledAlarmDate를 nil로 설정
        AlarmManager.shared.scheduledAlarmDate = nil
        completionHandler([.banner, .sound])
    }
    
    // 알림이 화면에 표시될 때 호출됨 (앱이 백그라운드에 있거나 기기가 잠겨있을 때)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 알림이 사용자에게 표시될 때 scheduledAlarmDate를 nil로 설정
        AlarmManager.shared.scheduledAlarmDate = nil
        completionHandler()
    }
    
}
