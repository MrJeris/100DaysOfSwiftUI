//
//  HabitListViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import Foundation

class HabitListViewModel: ObservableObject {
    @Published var habitItems = [HabitItem]() {
        didSet {
            if let encoder = try? JSONEncoder().encode(habitItems) {
                UserDefaults.standard.set(encoder, forKey: "HabitItems")
            }
        }
    }
    
    init() {
        if let savedHabitItems = UserDefaults.standard.data(forKey: "HabitItems") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedHabitItems) {
                habitItems = decodedItems
                return
            }
        }
        
        habitItems = []
    }
    
    func deleteHabit(at offsets: IndexSet) {
        var objectToDelete = IndexSet()
        
        for offset in offsets {
            let habitItem = habitItems[offset]
            
            if let index = habitItems.firstIndex(of: habitItem) {
                objectToDelete.insert(index)
            }
        }
        
        habitItems.remove(atOffsets: objectToDelete)
    }
    
    func decreaseCompletionCount() {
        
    }
}
