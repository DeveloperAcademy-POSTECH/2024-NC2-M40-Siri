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
        return .result(dialog: "수유를 시작합니다")
    }
}

struct EndFeedingIntent: AppIntent {
    static let title: LocalizedStringResource = "수유 종료"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        DispatchQueue.main.async {
            FeedingManager.shared.endFeeding(endTime: Date())
            
            let alarmTime = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            AlarmManager.shared.scheduleAlarm(at: alarmTime, withTitle: "수유시간", andBody: "아기 밥먹일 시간이에요!")
        }
        return .result(dialog: "수유를 종료하고, 3시간 뒤 알람을 설정했어요!")
    }
}

//단축어 자동 제공
struct FeedingShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddFeedingIntent(),
            phrases: ["\(.applicationName) 수유 시작",
                      "\(.applicationName) 맘마 먹자"],
            shortTitle: "수유 시작",
            systemImageName: "calendar"
        )
        AppShortcut(
            intent: EndFeedingIntent(),
            phrases: ["\(.applicationName) 수유 종료",
                      "\(.applicationName) 다 먹었다"],
            shortTitle: "분유 종료",
            systemImageName: "calendar"
        )
    }
}

