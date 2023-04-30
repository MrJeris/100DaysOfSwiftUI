//
//  ExpenseSection.swift
//  iExpense
//
//  Created by MrJeris on 24.04.2023.
//

import SwiftUI

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "RUB"))
                        .foregroundColor(item.amount < 10 ? .brown : item.amount < 100 ? .blue : .red)
                        .font(item.amount < 10 ? .title3 : item.amount < 100 ? .title2 : .title)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct ExpenseSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSection(title: "Example", expenses: [], deleteItems: { _ in })
    }
}
