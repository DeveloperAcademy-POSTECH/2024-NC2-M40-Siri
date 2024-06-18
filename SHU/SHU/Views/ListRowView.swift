//
//  ListRowView.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import SwiftUI

struct ListRowView: View {
    @ObservedObject private var feedingManager = FeedingManager.shared
    let feeding: Feeding
    let isNew: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            if isNew {
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Constants.orangePoint)
                        .frame(width: 78, height: 34)
                        .overlay {
                            Text("New")
                                .font(.system(size: 17))
                                .foregroundStyle(Color(red: 1, green: 0.95, blue: 0.83))
                                .fontWeight(.semibold)
                        }
                    Spacer()
                }
            }
            
            HStack {
                Text("시작 시간")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Spacer()
                Text(formattedDate(date: feeding.startTime))
                    .font(.system(size: 20))
            }
            HStack {
                Text("종료 시간")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Spacer()
                Text(formattedDate(date: feeding.endTime))
                    .font(.system(size: 20))
            }
            HStack {
                Text("소요 시간")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Spacer()
                Text("\(feeding.duration)")
                    .font(.system(size: 20))
            }
           
            HStack {
                Text("수유량")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Spacer()
                
                
                Stepper(value: $feedingManager.feedings[feedingManager.feedings.firstIndex(of: feeding)!].amount, in: 0...200, step: 5) {
                    EmptyView()
                }
                Text("\(feeding.amount) mL")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(width: 71)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(width: 366, alignment: .topLeading)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX") // "AM"과 "PM"을 영어로 출력
        return formatter.string(from: date)
    }
}

//#Preview {
//    ListRowView()
//}
