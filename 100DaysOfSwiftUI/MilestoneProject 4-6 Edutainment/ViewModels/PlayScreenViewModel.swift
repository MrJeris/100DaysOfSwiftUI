//
//  PlayScreenViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import Foundation

class PlayScreenViewModel: ObservableObject {
    @Published var goNextRound = false  //Переход к следующему раунду
    @Published var roundQuestion = ""   //Вопрос в раунде
    @Published var roundCorrectAnswer: Int = 0   //Правильный ответ
    @Published var inputResponse = ""   //Ввод пользователя в поле "ответ"
    @Published var roundNumber = 1      //Номер раунда
    @Published var alertTitle = ""      //Сообщение о правильности ответа
    @Published var rightSideOperand = 0 //На что умножается число
    @Published var playerScore = 0      //Счёт пользователя
    @Published var gameOver = false     //Конец игры
    
    var numberOfRounds: Int         //Количество всего раундов
    var multiplicationTable: Int    //Таблица умножения на число ...
    let rightSideOperandArray: [Int]
    
    init(numberOfRounds: Int, multiplicationTable: Int) {
        self.numberOfRounds = numberOfRounds
        self.multiplicationTable = multiplicationTable
        self.rightSideOperandArray = Array(1...numberOfRounds).shuffled()
        self.generateQuestion()
        self.generateAnswers()
    }

    func handleAnswerButtonTapped() {
        if let inputInt = try? Int(inputResponse) {
            if inputInt == roundCorrectAnswer {
                playerScore += 1
                alertTitle = "Верный ответ"
            } else {
                alertTitle = "Верный ответ \(roundCorrectAnswer)"
            }
            goNextRound = true
        }
    }
    
    func generateQuestion() {
        rightSideOperand = rightSideOperandArray[roundNumber - 1]
        roundQuestion = "\(multiplicationTable) x \(rightSideOperand)"
    }
    
    func generateAnswers() {
        roundCorrectAnswer = multiplicationTable * rightSideOperand
    }
    
    func moveToNextRound() {
        if roundNumber != numberOfRounds {
            roundNumber += 1
            generateQuestion()
            generateAnswers()
            inputResponse = ""
        } else {
            gameOver = true
        }
    }
}
