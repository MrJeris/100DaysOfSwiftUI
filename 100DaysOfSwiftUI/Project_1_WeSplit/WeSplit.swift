//
//  WeSplit.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct WeSplit: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let dollarFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        return (checkAmount * (1 + Double(tipPercentage) / 100)) / Double(numberOfPeople + 2)
    }
    
    var total: Double {
        return (checkAmount * (1 + Double(tipPercentage) / 100))
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: dollarFormat)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            Section {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0..<101) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text("How much tip do you want to leave?")
            }
            
            Section {
                Text(total, format: dollarFormat)
                    .foregroundColor(tipPercentage == 0 ? .red : .none)
            } header: {
                Text("Total amount")
            }
            
            Section {
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            } header: {
                Text("Amount per person")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
        .navigationTitle("WeSplit")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WeSplit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeSplit()
        }
    }
}
