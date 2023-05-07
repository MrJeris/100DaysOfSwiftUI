//
//  MainScreenView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 04.05.2023.
//

import SwiftUI


struct MainScreenView: View {
    //Game properties
    @StateObject var questionViewModel = QuestionViewModel()
    
    var body: some View {
        ZStack {
            Color(.brown)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Настройки игры")
                    .font(.largeTitle)
                    .padding(.bottom, 30)
                
                HStack(spacing: 0) {
                    Text("Выбери свою ")
                    Text("таблицу")
                        .fontWeight(.bold)
                    Text(" умножения")
                }
                
                //Номер таблицы умножения
                HStack {
                    ForEach(questionViewModel.multiplicationTableRange, id: \.self) { number in
                        Button {
                            questionViewModel.tableSelected = number
                        } label: {
                            Text("\(number)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .background(
                                    Circle()
                                        .fill(number == questionViewModel.tableSelected ? .gray : .blue)
                                        .shadow(radius: 1)
                                        .animation(.easeOut, value: questionViewModel.tableSelected)
                                )
                        }
                    }
                }
                
                Spacer()
                
                //Выбор количества вопросов
                Text("Выберите количество вопросов:")
                
                Picker("Выбор количества вопросов", selection: $questionViewModel.numberOfQuestions) {
                    ForEach(questionViewModel.numberOfRoundRange, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(.segmented)
                .background(.thinMaterial)
                .cornerRadius(8)
                .padding(.horizontal)
                
                
                Spacer()
                
                //Кнопка "Играть"
                NavigationLink(destination: PlayScreenView(
                    numberOfRounds: questionViewModel.numberOfQuestions,
                    multiplicationTable: questionViewModel.tableSelected
                )) {
                    Text("Играть")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Edutation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainScreenView()
        }
    }
}
