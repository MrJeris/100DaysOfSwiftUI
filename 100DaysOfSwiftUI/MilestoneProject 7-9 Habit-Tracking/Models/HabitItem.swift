//
//  HabitItem.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import Foundation

struct HabitItem: Identifiable, Equatable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var completionCount: Int = 0
    
    mutating func increaseCompletionCount() {
        completionCount += 1
    }
}
