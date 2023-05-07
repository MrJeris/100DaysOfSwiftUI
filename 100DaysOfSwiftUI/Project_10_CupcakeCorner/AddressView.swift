//
//  AddressView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 07.05.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderProvider: OrderProvider
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderProvider.order.name)
                TextField("Street address", text: $orderProvider.order.streetAddress)
                TextField("City", text: $orderProvider.order.city)
                TextField("Zip", text: $orderProvider.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderProvider: orderProvider)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!orderProvider.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderProvider: OrderProvider())
        }
    }
}
