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
    
    // 알림 수신시 (상황에 따른) 동작 정의
    // (앱이 포그라운드에 있는 경우) 알림이 화면에 표시되면 호출됨
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        AlarmManager.shared.cancelAlarm()
        completionHandler([.banner, .sound])
        
    }
    
    // (앱이 백그라운드에 있거나 기기가 잠겨있을 때) 사용자가 알림을 터치했을 때 호출됨
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        AlarmManager.shared.cancelAlarm()
        completionHandler()
        
    }
    
}
