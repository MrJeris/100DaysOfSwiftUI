//
//  ContentView1.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 13.05.2023.
//

import SwiftUI

struct ContentView1: View {
    @Environment(\.managedObjectContext) var moc
    private var friendFaceManager = FriendFaceManager()
    
    var body: some View {
        FriendFace()

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
