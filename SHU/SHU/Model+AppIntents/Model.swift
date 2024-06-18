//
//  Model.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import Foundation
import Combine
import UIKit
import UserNotifications

//수유일지 모델
class Feeding : Identifiable, Equatable {
    static func == (lhs: Feeding, rhs: Feeding) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var startTime: Date
    var endTime: Date
    var amount: Int
    
    //'O분' 형식으로 갈건데, 편의상 임시로 'O분 O초' 형식
    var duration: String {
        let totalSeconds = Int(endTime.timeIntervalSince(startTime))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return "\(minutes)분 \(seconds)초"
    }
    
    init(startTime: Date, endTime: Date, amount: Int) {
        self.startTime = startTime
        self.endTime = endTime
        self.amount = amount
    }
}

// 수유일지 저장 및 삭제 관리 모델(싱글톤)
class FeedingManager: ObservableObject {
    static let shared = FeedingManager()
    
    @Published var feedings: [Feeding] = []
    
    private init() {}
    
    private var ongoingFeeding: Feeding?
    
    // 분유 수유 시작
    func startFeeding(startTime: Date) {
        DispatchQueue.main.async {
            self.ongoingFeeding = Feeding(startTime: Date(), endTime: startTime, amount: 100)
        }
    }
    
    //분유 수유 종료 및 저장
    func endFeeding(endTime: Date) {
        DispatchQueue.main.async {
            if let newFeeding = self.ongoingFeeding {
                newFeeding.endTime = Date()
                self.ongoingFeeding = nil
                self.feedings.append(newFeeding)
            }
            
//            AlarmManager.shared.scheduleAlarm(after: 10, withTitle: "수유시간", andBody: "수유할 시간입니다!")
        }
    }
    
    //특정 수유 일지 삭제
    func deleteFeedings(at offsets: IndexSet) {
        DispatchQueue.main.async {
            self.feedings.remove(atOffsets: offsets)
        }
    }
    
    
    //가장 최근의 feeding은? (-> New 뱃지 때문에)
    func latestFeeding() -> Feeding? {
        return feedings.last
    }
}

//    // 수유량 업데이트
//    func updateFeedingAmount(feeding: Feeding, amount: Int) {
//        if let index = feedings.firstIndex(where: { $0.id == feeding.id }) {
//            feedings[index].amount = amount
//        }
//    }

//알 람 관리 모델(싱글톤)
class AlarmManager: ObservableObject {
    static let shared = AlarmManager()
    
    @Published var scheduledAlarmDate: Date? {
            didSet {
                if let date = scheduledAlarmDate {
                    UserDefaults.standard.set(date, forKey: "scheduledAlarmDate")
                } else {
                    UserDefaults.standard.removeObject(forKey: "scheduledAlarmDate")
                }
            }
        }
    
    private init() {
            if let date = UserDefaults.standard.object(forKey: "scheduledAlarmDate") as? Date {
                scheduledAlarmDate = date
            }
        }
    
    //알람 설정
    func scheduleAlarm(at date: Date, withTitle title: String, andBody body: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm.mp3"))
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                dateComponents.second = 0 // 정확한 분에 알람이 울리도록 설정
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알람 설정 중 오류 발생: \(error)")
            }
        }
        
        scheduledAlarmDate = date
    }
    
    func updateAlarm(at date: Date, withTitle title: String, andBody body: String) {
        DispatchQueue.main.async {
            self.cancelAlarm()
            self.scheduleAlarm(at: date, withTitle: title, andBody: body)
        }
    }
    
    func cancelAlarm() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        scheduledAlarmDate = nil
    }

    
}
