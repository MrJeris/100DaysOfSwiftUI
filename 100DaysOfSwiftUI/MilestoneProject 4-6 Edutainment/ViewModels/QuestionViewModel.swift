//
//  QuestionViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import Foundation

class QuestionViewModel: ObservableObject {
    @Published var tableSelected = 4    //Выбранная таблица умножения (по умолчанию 4)
    @Published var numberOfQuestions = 9       //Выбранное колчичество вопросов (по умолчанию 9)
    
    //Constant
    let numberOfRoundRange = [6, 9, 12, 15]
    let multiplicationTableRange = 2...10
}
