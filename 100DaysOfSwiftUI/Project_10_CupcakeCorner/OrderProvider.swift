//
//  OrderProvider.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 07.05.2023.
//

import Foundation

class OrderProvider: ObservableObject {
    @Published var order = Order()
}
