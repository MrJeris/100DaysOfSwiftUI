//
//  PlayScreenView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import SwiftUI

struct PlayScreenView: View {
    @StateObject var playSreenViewModel: PlayScreenViewModel
    @ObservedObject var questionViewModel: QuestionViewModel
    @Environment(\.dismiss) var backMainScreen
    
    init(numberOfRounds: Int, multiplicationTable: Int, questionViewModel: QuestionViewModel) {
        _playSreenViewModel = StateObject(wrappedValue: PlayScreenViewModel(
            numberOfRounds: numberOfRounds,
            multiplicationTable: multiplicationTable))
        self.questionViewModel = questionViewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.gray)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    //Номер вопроса
                    HStack(spacing: 0) {
                        Text("Вопрос ")
                        Text("\(playSreenViewModel.roundNumber)")
                            .foregroundColor(.green)
                            .fontWeight(.heavy)
                            .animation(.default, value: playSreenViewModel.roundNumber)
                        Text(" / ")
                        Text("\(playSreenViewModel.numberOfRounds)")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(8)
                    .background(.black)
                    .cornerRadius(8)
                    
                    Text("Счёт \(playSreenViewModel.playerScore)")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(.thinMaterial)
                        .cornerRadius(30)
                        .animation(.default, value: playSreenViewModel.playerScore)
                    
                    Spacer()
                    
                    //Блок с вопросом
                    VStack {
                        Text("Сколько будет?")
                            .fontWeight(.bold)
                            .font(.title2)
                            .padding([.bottom, .top], 4)
                        
                        HStack {
                            Spacer()
                            
                            Text(playSreenViewModel.roundQuestion)
                                .animation(.default, value: playSreenViewModel.roundQuestion)
                                .padding(.bottom, 4)
                            
                            Spacer()
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    }
                    .background(
                        Color(red: 243/255, green: 186/255, blue: 109/255, opacity: 0.6)
                    )
                    .overlay(Rectangle()
                        .stroke(Color.clear)
                        .shadow(radius: 1)
                    )
                    
                    //Поле ввода + клавиатура
                    VStack {
                        //Поле ввода
                        HStack {
                            Text(playSreenViewModel.inputResponse)
                                .frame(width: 160, height: 50, alignment: .center)
                                .font(.title)
                                .foregroundColor(.black)
                                .background(Color(.white))
                                .cornerRadius(15)
                                .shadow(radius: 4)
                            
                            //Кнопка ввода
                            Button {
                                playSreenViewModel.handleAnswerButtonTapped()
                            } label: {
                                Image(systemName: "arrowtriangle.right.circle")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.green)
                                    .shadow(radius: 3)
                            }
                        }
                        .padding()
                        
                        //Клавиатура
                        KeyboardView(answer: $playSreenViewModel.inputResponse)
                            .frame(width: 350, height: 350)
                    }
                }
            }
            .alert(playSreenViewModel.alertTitle, isPresented: $playSreenViewModel.goNextRound, actions: {
                Button("Продолжить", role: .cancel) {
                    playSreenViewModel.moveToNextRound()
                }
            })
            .alert("Поздравляем, вы закончили с счётом \(playSreenViewModel.playerScore)", isPresented: $playSreenViewModel.gameOver, actions: {
                Button("Вернуться на главное меню", role: .cancel) {
                    backMainScreen()
                }
            })
        }
        .navigationTitle("Умножение на \(playSreenViewModel.multiplicationTable)")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct PlayScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PlayScreenView(numberOfRounds: QuestionViewModel().numberOfQuestions,
                       multiplicationTable: QuestionViewModel().tableSelected,
                       questionViewModel: QuestionViewModel())
    }
}
