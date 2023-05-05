//
//  KeyboardView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import SwiftUI

struct KeyboardView: View {
    @Binding var answer: String
    
    var body: some View {
        VStack {
            ForEach(datas) { i in
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        ForEach(i.row) { j in
                            Button {
                                if j.value == "delete.left.fill" {
                                    if answer.count > 0 {
                                        answer = String(answer.dropLast())
                                    }
                                } else {
                                    answer.append(j.value)
                                }
                            } label: {
                                if j.value == "delete.left.fill" {
                                    Circle()
                                        .overlay(
                                            Image(systemName: j.value)
                                                .foregroundColor(.white)
                                                .font(.title)
                                        )
                                } else {
                                    Circle()
                                        .overlay(
                                            Text(j.value)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                                .font(.title)
                                        )
                                }
                            }
                            .padding()
                            .frame(width: geometry.size.width / 3)
                            .foregroundColor(.brown)
                            .shadow(radius: 2)
                        }
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(answer: .constant("15"))
    }
}



struct line: Identifiable {
    var id: Int
    var row: [row]
}

struct row: Identifiable {
    var id: Int
    var value: String
}

var datas = [
    line(id: 0, row: [row(id: 0, value: "1"), row(id: 1, value: "2"), row(id: 2, value: "3")]),
    line(id: 1, row: [row(id: 0, value: "4"), row(id: 1, value: "5"), row(id: 2, value: "6")]),
    line(id: 2, row: [row(id: 0, value: "7"), row(id: 1, value: "8"), row(id: 2, value: "9")]),
    line(id: 3, row: [row(id: 0, value: "delete.left.fill"), row(id: 1, value: "0")])
]
