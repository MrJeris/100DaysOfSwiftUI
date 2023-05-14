//
//  DataController2.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 12.05.2023.
//

import CoreData

class DataController2: ObservableObject {
    let container = NSPersistentContainer(name: "CoreData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Cannot load data \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
