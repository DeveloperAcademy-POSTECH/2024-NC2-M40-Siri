//
//  AlarmView.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject private var alarmManager = AlarmManager.shared
    @State private var isShowingTimePicker: Bool = false
    @State private var selectedTime: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "alarm")
                    .foregroundStyle(Constants.orangePoint)
                    .font(.system(size: 22))
                
                Text("다음 알람 시간")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Spacer()
            }
            .frame(width: 334)
            
            if let scheduledAlarmDate = alarmManager.scheduledAlarmDate {
                Text(formattedDate(date: scheduledAlarmDate))
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .frame(width: 334)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Constants.orangeMain)
                        .frame(width: 103, height: 40)
                        .shadow(color: .black.opacity(0.25), radius: 5)
                        .overlay {
                            Text("수정")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                        }
                        .onTapGesture {
                            selectedTime = scheduledAlarmDate
                            isShowingTimePicker = true
                        }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Constants.orangePoint)
                        .frame(width: 103, height: 40)
                        .shadow(color: .black.opacity(0.25), radius: 5)
                        .overlay {
                            Text("삭제")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                        }
                        .onTapGesture {
                            //여기에 삭제 로직
                        }
                        .padding(.vertical, 10)
                }
                .frame(width: 334)
            }
            else {
                Text("설정된 알람이 없어요!")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .frame(width: 334, height: 137)
            }
        }
        .frame(width: 366, height: 195)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: -0.25)
                .stroke(Color(red: 0.78, green: 0.78, blue: 0.8), lineWidth: 0.5)
        )
        .sheet(isPresented: $isShowingTimePicker) {
            TimePickerView(selectedTime: $selectedTime, temporaryTime: selectedTime)
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX") // "AM"과 "PM"을 영어로 출력
        return formatter.string(from: date)
    }
}

#Preview {
    AlarmView()
}
