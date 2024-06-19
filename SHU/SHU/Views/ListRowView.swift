//
//  ListRowView.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import SwiftUI

struct ListRowView: View {
    @ObservedObject private var feedingManager = FeedingManager.shared
    @ObservedObject var feeding: Feeding
    let isNew: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            if isNew {
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("pointColor"))
                        .frame(width: 73, height: 34)
                        .overlay {
                            Text("NEW")
                                .font(.system(size: 17))
                                .foregroundStyle(Color(red: 1, green: 0.95, blue: 0.83))
                                .fontWeight(.bold)
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
                
                
                Text("\(feeding.amount) cc")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                HStack {
                    Button(action: {
                        feeding.amount = max(0, feeding.amount - 5)
                        
                    }) {
                        Image(systemName: "minus")
                            .frame(width: 33, height: 30)
                            .foregroundStyle(.black)
                            .background(Color("editColor"))
                    }
                    
                    
                    Divider()
                    
                    
                    Button(action: {
                        feeding.amount = min(200, feeding.amount + 5)
                        
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 33, height: 30)
                            .foregroundStyle(.black)
                            .background(Color("editColor"))
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .background(RoundedRectangle(cornerRadius: 7)
                    .fill(Color("editColor"))
                    .frame(width: 100))
                .frame(width: 100, height: 30)
                .padding(.leading, 5)
            
            }
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 10)
        .frame(width: 341, alignment: .topLeading)
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
