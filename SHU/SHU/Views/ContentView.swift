//
//  ContentView.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @ObservedObject private var feedingManager = FeedingManager.shared
    @ObservedObject private var alarmManager = AlarmManager.shared
    @State private var showAlert = false
    @State private var selectedDate = Date()
    @State private var isShowingDatePicker = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        ZStack {
            Constants.backGround
                .ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Text("수유 기록")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                    Spacer()
                }
                .frame(width: 366)
                
                AlarmView(showDeleteAlert: $showDeleteAlert)
                    .padding(.bottom, 20)
                
                
                VStack {
                    
                    Divider()
                    HStack {
                        Text(formattedDate(date: selectedDate))
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                            .onTapGesture {
                                isShowingDatePicker = true
                            }
                    }
                    .frame(width: 366, height: 22)
                    Divider()
                }
                .padding(0)
                
                List {
                    ForEach(feedingManager.feedings.filter { Calendar.current.isDate($0.startTime, inSameDayAs: selectedDate) }.reversed()) { feeding in
                        ListRowView(feeding: feeding, isNew: feeding == feedingManager.latestFeeding())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            .sheet(isPresented: $isShowingDatePicker) {
                DatePickerView(selectedDate: $selectedDate, temporaryDate: selectedDate)
                    .presentationDetents([.height(400), .medium, .large])
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("알림 권한이 필요합니다"),
                    message: Text("알람 기능을 사용하기 위해, 설정에서 알림 권한을 허용해주세요."),
                    primaryButton: .default(Text("설정으로 이동")) {
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                        UIApplication.shared.open(settingsURL)
                    },
                    secondaryButton: .cancel(Text("취소"))
                )
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("알람을 삭제하시곘어요?"), message: Text("삭제된 알람은 복원되지 않습니다."), primaryButton: .destructive(Text("삭제")) {
                alarmManager.cancelAlarm()
            }, secondaryButton: .cancel(Text("취소")))
        }
        .onAppear {
            checkNotificationPermission()
        }
    }
    
    private func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .notDetermined {
                    self.requestNotificationPermission()
                } else if settings.authorizationStatus == .denied {
                    print("알림 권한이 거부되었습니다")
                    self.showAlert = true
                } else if settings.authorizationStatus == .authorized {
                    self.showAlert = false
                }
            }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("알림 권한 요청 중 오류 : \(error)")
                }
                self.showAlert = !granted
            }
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        feedingManager.deleteFeedings(at: offsets)
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
