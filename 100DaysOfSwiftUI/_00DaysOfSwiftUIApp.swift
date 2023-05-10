//
//  _00DaysOfSwiftUIApp.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

@main
struct _00DaysOfSwiftUIApp: App {
    //@StateObject private var dataController = DataController()
    @StateObject private var dataController1 = DataController1()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.managedObjectContext, dataController1.container.viewContext)
        }
    }
}
