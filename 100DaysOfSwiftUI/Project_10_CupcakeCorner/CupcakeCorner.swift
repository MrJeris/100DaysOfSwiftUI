//
//  CupcakeCorner.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct CupcakeCorner: View {
    @StateObject var order = Order()
    
    var body: some View {
        Form {
            Section {
                Picker("Select your cake type", selection: $order.type) {
                    ForEach(Order.types.indices) {
                        Text(Order.types[$0])
                    }
                }
                
                Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
            }
            
            Section {
                Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                
                if order.specialRequestEnabled {
                    Toggle("Add extra frosting", isOn: $order.extraFrosting)
                    Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                }
            }
            
            Section {
                NavigationLink {
                    AddressView(order: order)
                } label: {
                    Text("Delivery details")
                }
            }
        }
        .navigationTitle("Cupcake Corner")
    }
}

struct CupcakeCorner_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCorner()
    }
}