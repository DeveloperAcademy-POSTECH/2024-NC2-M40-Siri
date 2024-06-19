//
//  AppIntents.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import Foundation
import AppIntents

struct AddFeedingIntent: AppIntent {
    static let title: LocalizedStringResource = "수유 시작"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
            FeedingManager.shared.startFeeding(startTime: Date())
        return .result(dialog: "네, 기록을 시작할게요~")
    }
}

struct EndFeedingIntent: AppIntent {
    static let title: LocalizedStringResource = "수유 종료"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        DispatchQueue.main.async {
            FeedingManager.shared.endFeeding(endTime: Date())
            
            let alarmTime = Calendar.current.date(byAdding: .hour, value: 3, to: Date())!
            AlarmManager.shared.scheduleAlarm(at: alarmTime, withTitle: "수유시간", andBody: "아기 밥먹일 시간이에요!")
        }
        return .result(dialog: "고생하셨어요! 3시간 뒤에 알려드릴게요!")
    }
}

//단축어 자동 제공
struct FeedingShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddFeedingIntent(),
            phrases: ["\(.applicationName) 수유시작",
                      "\(.applicationName) 맘마먹자",
                     "\(.applicationName) 분유 먹일게",
                     "\(.applicationName) 밥 먹일게"],
            shortTitle: "수유 시작",
            systemImageName: "calendar"
        )
        AppShortcut(
            intent: EndFeedingIntent(),
            phrases: ["\(.applicationName) 수유종료",
                      "\(.applicationName) 다먹었다",
                     "\(.applicationName) 수유 끝났어",
                     "\(.applicationName) 수유 끝",
                     "\(.applicationName) 다 먹였어"],
            shortTitle: "수유 종료",
            systemImageName: "calendar"
        )
    }
}

