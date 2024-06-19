//
//  DatePickerView.swift
//  SHU
//
//  Created by 김현수 on 6/18/24.
//

import SwiftUI

struct DatePickerView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedDate: Date
    @State var temporaryDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("날짜 선택")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            DatePicker("", selection: $temporaryDate, displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "ko_KR"))
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("editColor"))
                .frame(height: 44)
                .shadow(color: .black.opacity(0.25), radius: 5)
                .overlay {
                    Text("적용")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                }
                .onTapGesture {
                    selectedDate = temporaryDate
                    dismiss()
                }
        }
        .frame(width: 309)
    }
}

//#Preview {
//    DatePickerView()
//}
