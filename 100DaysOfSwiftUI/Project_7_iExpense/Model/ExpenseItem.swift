//
//  ExpenseItem.swift
//  iExpense
//
//  Created by MrJeris on 24.04.2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
