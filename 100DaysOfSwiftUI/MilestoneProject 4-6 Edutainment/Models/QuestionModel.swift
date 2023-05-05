//
//  QuestionModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import Foundation

struct QuestionModel {
    let firstNumber: Int    //Первое число умножения
    let secondNumber: Int   //Второе число умножения
    var tableNumber: Int = 0   //   Какое из чисел является частью таблицы умножения (по умолчанию первая)
    var goodAnswer: Int {
        firstNumber * secondNumber
    }
    var position: Int
    var wellAnswered = false
}
