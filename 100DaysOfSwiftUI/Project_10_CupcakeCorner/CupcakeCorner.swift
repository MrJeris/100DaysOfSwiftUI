//
//  CupcakeCorner.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct CupcakeCorner: View {
    @StateObject var orderProvider = OrderProvider()
    
    var body: some View {
        Form {
            Section {
                Picker("Select your cake type", selection: $orderProvider.order.type) {
                    ForEach(Order.types.indices) {
                        Text(Order.types[$0])
                    }
                }
                
                Stepper("Number of cakes: \(orderProvider.order.quantity)", value: $orderProvider.order.quantity, in: 3...20)
            }
            
            Section {
                Toggle("Any special requests?", isOn: $orderProvider.order.specialRequestEnabled.animation())
                
                if orderProvider.order.specialRequestEnabled {
                    Toggle("Add extra frosting", isOn: $orderProvider.order.extraFrosting)
                    Toggle("Add extra sprinkles", isOn: $orderProvider.order.addSprinkles)
                }
            }
            
            Section {
                NavigationLink {
                    AddressView(orderProvider: orderProvider)
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
