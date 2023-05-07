//
//  RockPaperAndScissor.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct RockPaperAndScissor: View {
    let possobleMoves = ["✊🏽", "✌🏽", "✋🏽"]
    
    @State private var currentChoiceApp = Int.random(in: 0 ..< 3)
    @State private var winOrLose = Bool.random()
    
    @State private var playerScore = 0
    @State private var questionCount = 1
    
    @State private var result = ""
    @State private var showingResult = false
    @State private var showingEndGameResult = false
    
    private var correctAnswer: Int {
        winOrLose ? (currentChoiceApp + 2) % 3 : (currentChoiceApp + 1) % 3
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 245 / 255, green: 245 / 255 , blue: 220 / 255),
                                    .mint], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 20) {
                Spacer()
                
                Text("Ваш счёт: \(playerScore)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                Spacer()
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Компьютер выбрал")
                            .font(.title)
                        Text(possobleMoves[currentChoiceApp])
                            .font(.largeTitle)
                    }
                    
                    
                    Text("Вы должны \(winOrLose ? "выиграть" : "проиграть")")
                        .font(.headline.bold())
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.regularMaterial, lineWidth: 5))
                }
                
                VStack {
                    Text("Что вы выберите?")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding()
                    HStack(spacing: 60) {
                        ForEach(0 ..< 3) { item in
                            Button {
                                if questionCount == 10 {
                                    playerScore += 1
                                    result = "Поздравляем, твой счёт \(playerScore)"
                                    showingEndGameResult = true
                                }
                                else if item == correctAnswer {
                                    playerScore += 1
                                    result = "Правильно"
                                    questionCount += 1
                                    showingResult = true
                                } else {
                                    if playerScore > 0 {
                                        playerScore -= 1
                                    }
                                    result = "Неправильно"
                                    questionCount += 1
                                    showingResult = true
                                }
                            } label: {
                                Text("\(possobleMoves[item])")
                                    .font(.largeTitle)
                            }
                        }
                    }
                    .padding()
                }
                .background(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
            }
            .alert(result, isPresented: $showingResult) {
                Button("Продолжить", action: continueGame)
            }
            .alert(result, isPresented: $showingEndGameResult) {
                Button("Перезапустить игру", action: restartGame)
            }
        }
        .navigationTitle("Rock Paper and Scissor")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func restartGame() {
        continueGame()
        playerScore = 0
        questionCount = 1
    }
    
    func continueGame() {
        withAnimation {
            currentChoiceApp = Int.random(in: 0 ..< 3)
            winOrLose = Bool.random()
        }
    }
}

struct RockPaperAndScissor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RockPaperAndScissor()
        }
    }
}
