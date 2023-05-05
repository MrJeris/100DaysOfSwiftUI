//
//  ContentViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import Foundation

class EdutainmentViewModel: ObservableObject {
    @Published var multiplicationTable = 2
    @Published var numberOfRounds = 5
    
    private var roundAnswers = [Int]()
    private var roundCorrectAnswer = 0
}
