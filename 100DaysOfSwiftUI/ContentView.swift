//
//  ContentView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct ContentView: View {
    let lesson: [AnyView] = [
        AnyView(WeSplit()),
        AnyView(GuessTheFlag()),
        AnyView(ViewsAndModifiers()),
        AnyView(BetterRest()),
        AnyView(WordScramble()),
        AnyView(Animation()),
        AnyView(iExpenseView()),
        AnyView(Moonshot(astronauts: Bundle.main.decode("astronauts.json"), missions: Bundle.main.decode("missions.json"))),
        AnyView(Drawing()),
        AnyView(CupcakeCorner()),
        AnyView(Bookworm()),
        AnyView(CoreDataProject()),
        AnyView(InstafilterView())
    ]
    
    let milestone: [AnyView] = [
        AnyView(RockPaperAndScissor()),
        AnyView(Edutainment()),
        AnyView(HabitTracking()),
        AnyView(FriendFace())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    Text("Projects")
                        .font(.title)
                        .fontWeight(.medium)
                        .fontDesign(.monospaced)
                    
                    
                    ForEach(0..<lesson.count) { lessonIndex in
                        NavigationLink("Project \(lessonIndex + 1)", destination: lesson[lessonIndex])
                            .font(.headline)
                    }
                        
                    Text("Milestone Projects")
                        .font(.title)
                        .fontWeight(.medium)
                        .fontDesign(.monospaced)
                        .padding(.top, 40)
                    
                    ForEach(0..<milestone.count) { milestoneIndex in
                        NavigationLink("Milestone \(milestoneIndex + 1)", destination: milestone[milestoneIndex])
                            .font(.headline)
                    }
                }
                .padding()
            }
            .background(LinearGradient(colors: [Color(red: 245 / 255, green: 245 / 255 , blue: 220 / 255), .mint], startPoint: .top, endPoint: .bottom))
            .navigationTitle("100 Days of SwiftUI")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
