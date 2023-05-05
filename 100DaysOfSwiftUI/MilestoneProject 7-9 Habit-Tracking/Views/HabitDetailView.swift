//
//  HabitDetailView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 02.05.2023.
//

import SwiftUI

struct HabitDetailView: View {
    @Binding var habitItem: HabitItem
    
    var body: some View {
        VStack {
            VStack {
                Text(habitItem.title)
                    .font(.title)
                Text(habitItem.description)
                HStack {
                    Text("Just compleated this habit?")
                    Image(systemName: "plus.circle")
                        .onTapGesture {
                            habitItem.increaseCompletionCount()
                        }
                }
                Text("\(habitItem.completionCount)")
            }
            Spacer()
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habitItem: .constant(HabitItem(title: "Swift", description: "Swift Description")))
    }
}
