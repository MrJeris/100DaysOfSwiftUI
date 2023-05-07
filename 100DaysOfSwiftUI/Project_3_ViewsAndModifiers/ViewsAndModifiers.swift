//
//  ViewsAndModifiers.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func largeBlue() -> some View {
        modifier(LargeBlueFont())
    }
}

struct ViewsAndModifiers: View {
    var body: some View {
        VStack {
            Spacer()
            
            Section {
                Text("Defaul text")
                Text("Text with custom modification")
                    .largeBlue()
            }
            
            Spacer()
            Spacer()
        }
        .navigationTitle("ViewsAndModifiers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViewsAndModifiers()
        }
    }
}
