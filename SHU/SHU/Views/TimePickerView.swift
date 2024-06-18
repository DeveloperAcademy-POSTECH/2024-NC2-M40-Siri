//
//  TimePickerView.swift
//  SHU
//
//  Created by 김현수 on 6/19/24.
//

import SwiftUI

struct TimePickerView: View {
    @ObservedObject private var alarmManager = AlarmManager.shared
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTime: Date
    @State var temporaryTime: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("시간 선택")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                Spacer()
            }
            
            DatePicker("", selection: $temporaryTime, displayedComponents: [.hourAndMinute])
                .datePickerStyle(.wheel)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "ko_KR"))
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Constants.orangeMain)
                .frame(height: 44)
                .shadow(color: .black.opacity(0.25), radius: 5)
                .overlay {
                    Text("수정하기")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                }
                .onTapGesture {
                    selectedTime = temporaryTime
                    alarmManager.updateAlarm(at: selectedTime, withTitle: "수유시간", andBody: "아기 밥먹일 시간이에요!")
                    dismiss()
                }
            
        }
        .frame(width: 309)
    }
}

//#Preview {
//    TimePickerView()
//}
