//
//  BetterRest.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

import SwiftUI
import CoreML

struct BetterRest: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var idealTime = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        Form {
            Section {
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            } header: {
                Text("When do you want to wake up?")
                    .font(.headline)
            }
            
            Section {
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            } header: {
                Text("Desired amount of sleep")
                    .font(.headline)
            }
            
            Section {
                Picker("\(coffeeAmount) cups", selection: $coffeeAmount) {
                    ForEach(0..<21) {
                        Text("\($0)")
                    }
                }
            } header: {
                Text("Daily coffee intake")
                    .font(.headline)
            }
            
            Text("Your ideal bedtime is \(calculateBedtime())")
                .font(.title)
        }
        .navigationTitle("BetterRest")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func calculateBedtime() -> String{
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return ""
        }
    }
}

struct BetterRest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BetterRest()
        }
    }
}
