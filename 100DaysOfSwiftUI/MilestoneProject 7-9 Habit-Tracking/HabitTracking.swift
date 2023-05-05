//
//  HabitTracking.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct HabitTracking: View {
    @StateObject var habits = HabitListViewModel()
    
    var body: some View {
        HabitListView(habits: habits)
    }
}

struct HabitTracking_Previews: PreviewProvider {
    static var previews: some View {
        HabitTracking()
    }
}
