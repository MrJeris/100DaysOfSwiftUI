//
//  HabbitCreateView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 02.05.2023.
//

import SwiftUI

struct HabitCreateView: View {
    @ObservedObject var habitsItems: HabitListViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var completionCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                TextField("Description", text: $description)
            }
            .navigationTitle("Add new Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let habitItem = HabitItem(title: title, description: description)
                    habitsItems.habitItems.append(habitItem)
                    dismiss()
                }
            }
        }
    }
}

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCreateView(habitsItems: HabitListViewModel())
    }
}
