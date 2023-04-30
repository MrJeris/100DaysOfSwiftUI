//
//  ViewDivider.swift
//  Moonshot
//
//  Created by MrJeris on 25.04.2023.
//

import SwiftUI

struct ViewDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct ViewDivider_Previews: PreviewProvider {
    static var previews: some View {
        ViewDivider()
    }
}
