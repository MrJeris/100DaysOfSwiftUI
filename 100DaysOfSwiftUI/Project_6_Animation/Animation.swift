//
//  Animation.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct Animation: View {
    @State private var isShowingRed = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                    
                    if isShowingRed {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200, height: 200)
                            .transition(.pivot)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
                NavigationLink("Challenge: Guess the Flag add some animation", destination: GuessTheFlag())
            }
        }
        .navigationTitle("Animation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        Animation()
    }
}
