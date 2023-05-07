//
//  HabitListView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct HabitListView: View {
    @ObservedObject var habits: HabitListViewModel
    @State private var showingCreateView = false
    
    var body: some View {
        List {
            ForEach($habits.habitItems) { $item in
                NavigationLink(item.title) {
                    HabitDetailView(habitItem: $item)
                }
            }
            .onDelete(perform: habits.deleteHabit)
        }
        .toolbar{
            Button {
                showingCreateView = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingCreateView) {
            HabitCreateView(habitsItems: habits)
        }
        .navigationTitle("Habit-Tracking")
    }
}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitListView(habits: HabitListViewModel())
        }
    }
}
